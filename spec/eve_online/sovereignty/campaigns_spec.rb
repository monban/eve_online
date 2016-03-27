require 'spec_helper'

describe EveOnline::Sovereignty::Campaigns do
  specify { expect(described_class::API_ENDPOINT).to eq('https://public-crest.eveonline.com/sovereignty/campaigns/') }
  specify { expect(subject.url).to eq(described_class::API_ENDPOINT) }
  specify { expect(subject).to be_a(EveOnline::Base) }
  specify { expect(subject).to be_a(EveOnline::Sovereignty::Campaigns) }
  specify { expect(subject.parser).to eq(JSON) }
  specify { expect(subject).to_not respond_to(:eveapi) }
  specify { expect(subject).to_not respond_to(:cached_until) }
  specify { expect(subject).to_not respond_to(:current_time) }

  describe '#initialize' do
    specify { expect{described_class.new}.to_not raise_error }
  end

  describe '#results' do
    let(:response) { double }

    let(:content) { 'some json content' }

    before { expect(response).to receive(:fetch).and_return(content) }
    before { expect(subject).to receive(:response).and_return(response) }

    specify { expect { subject.result }.not_to raise_error }
  end

  describe '#response' do
    let(:parser) { double }

    let(:content) { 'some xml content' }

    before { expect(subject).to receive(:content).and_return(content) }

    before { expect(subject).to receive(:parser).and_return(parser) }

    before { expect(parser).to receive(:parse).with(content) }

    specify { expect { subject.response }.not_to raise_error }
  end

  describe '#url' do
    specify { expect(subject.url).to eq(described_class::API_ENDPOINT) }
  end
end

