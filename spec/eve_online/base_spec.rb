require 'spec_helper'

describe EveOnline::Base do
  describe '#initialize' do
    let(:parser) { double }

    before do
      #
      # Nori.new(advanced_typecasting: false) => double
      #
      expect(Nori).to receive(:new).with(advanced_typecasting: false).and_return(parser)
    end

    its(:parser) { should eq(parser) }
  end

  describe '#result' do
    before do
      #
      # subject.eveapi.fetch('result')
      #
      expect(subject).to receive(:eveapi) do
        double.tap do |a|
          expect(a).to receive(:fetch).with('result')
        end
      end
    end

    specify { expect { subject.result }.not_to raise_error }
  end

  describe '#url' do
    specify { expect { subject.url }.to raise_error(NotImplementedError) }
  end

  describe '#user_agent' do
    specify { expect(subject.user_agent).to eq("EveOnline API (https://github.com/biow0lf/eve_online) v#{ EveOnline::VERSION }") }
  end

  describe '#content' do
    let(:url) { double }

    before { expect(subject).to receive(:url).and_return(url) }

    let(:user_agent) { double }

    before { expect(subject).to receive(:user_agent).and_return(user_agent) }

    before do
      #
      # subject.open(url, open_timeout: 60, read_timeout: 60, 'User-Agent' => user_agent).read
      #
      expect(subject).to receive(:open).with(url, open_timeout: 60, read_timeout: 60, 'User-Agent' => user_agent) do
        double.tap do |a|
          expect(a).to receive(:read)
        end
      end
    end

    specify { expect { subject.content }.not_to raise_error }
  end

  describe '#response' do
    let(:parser) { double }

    let(:content) { 'some xml content to parse' }

    before { expect(subject).to receive(:content).and_return(content) }

    before { expect(subject).to receive(:parser).and_return(parser) }

    before { expect(parser).to receive(:parse).with(content) }

    specify { expect { subject.response }.not_to raise_error }
  end
end
