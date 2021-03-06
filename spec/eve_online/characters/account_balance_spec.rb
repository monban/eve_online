require 'spec_helper'

describe EveOnline::Characters::AccountBalance do
  let(:key_id) { 123 }

  let(:v_code) { 'abc' }

  let(:character_id) { 12_345_678 }

  subject { described_class.new(key_id, v_code, character_id) }

  specify { expect(subject).to be_a(EveOnline::Base) }

  specify { expect(described_class::API_ENDPOINT).to eq('https://api.eveonline.com/char/AccountBalance.xml.aspx') }

  describe '#initialize' do
    its(:key_id) { should eq(key_id) }

    its(:v_code) { should eq(v_code) }

    its(:character_id) { should eq(character_id) }
  end

  describe '#as_json' do
    let(:account_balance) { described_class.new(key_id, v_code, character_id) }

    let(:current_time) { double }

    let(:cached_until) { double }

    before { expect(account_balance).to receive(:account_id).and_return(42_763_123) }

    before { expect(account_balance).to receive(:account_key).and_return(1_000) }

    before { expect(account_balance).to receive(:balance).and_return('5000.00') }

    before { expect(account_balance).to receive(:current_time).and_return(current_time) }

    before { expect(account_balance).to receive(:cached_until).and_return(cached_until) }

    subject { account_balance.as_json }

    its([:account_id]) { should eq(42_763_123) }

    its([:account_key]) { should eq(1_000) }

    its([:balance]) { should eq('5000.00') }

    its([:current_time]) { should eq(current_time) }

    its([:cached_until]) { should eq(cached_until) }
  end

  describe '#account_id' do
    before do
      #
      # subject.row.fetch('@accountID').to_i
      #
      expect(subject).to receive(:row) do
        double.tap do |a|
          expect(a).to receive(:fetch).with('@accountID') do
            double.tap do |b|
              expect(b).to receive(:to_i)
            end
          end
        end
      end
    end

    specify { expect { subject.account_id }.not_to raise_error }
  end

  describe '#account_key' do
    before do
      #
      # subject.row.fetch('@accountKey').to_i
      #
      expect(subject).to receive(:row) do
        double.tap do |a|
          expect(a).to receive(:fetch).with('@accountKey') do
            double.tap do |b|
              expect(b).to receive(:to_i)
            end
          end
        end
      end
    end

    specify { expect { subject.account_key }.not_to raise_error }
  end

  describe '#balance' do
    before do
      #
      # subject.row.fetch('@balance')
      #
      expect(subject).to receive(:row) do
        double.tap do |a|
          expect(a).to receive(:fetch).with('@balance')
        end
      end
    end

    specify { expect { subject.balance }.not_to raise_error }
  end

  describe '#row' do
    before do
      #
      # subject.rowset.fetch('row')
      #
      expect(subject).to receive(:rowset) do
        double.tap do |a|
          expect(a).to receive(:fetch).with('row')
        end
      end
    end

    specify { expect { subject.row }.not_to raise_error }
  end

  describe '#rowset' do
    before do
      #
      # subject.result.fetch('rowset')
      #
      expect(subject).to receive(:result) do
        double.tap do |a|
          expect(a).to receive(:fetch).with('rowset')
        end
      end
    end

    specify { expect { subject.rowset }.not_to raise_error }
  end

  describe '#url' do
    specify do
      expect(subject.url).to eq("#{ described_class::API_ENDPOINT }?keyID=#{ key_id }&vCode=#{ v_code }&characterID=#{ character_id }")
    end
  end
end
