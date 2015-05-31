require 'spec_helper'

describe ActivePStore::Base do
  include_context 'Rock stars on stage'

  describe '.count' do
    subject { Artist.count }

    context 'exists data' do
      it { is_expected.to eq(4) }
    end

    context 'empty data' do
      before do
        Artist.destroy_all
      end

      it { is_expected.to be_zero }
    end
  end

  describe '.destroy_all' do
    describe 'return value' do
      subject { Artist.destroy_all }

      it { is_expected.to eq(4) }
    end

    describe 'destroy data' do
      before do
        Artist.destroy_all
      end

      subject { Artist.all }

      it { is_expected.to be_an(Array) }
      it { is_expected.to be_empty }
    end
  end

  describe '.update_all' do
    describe 'return value' do
      subject { Artist.update_all(associated_act: 'The Super Band') }

      it { is_expected.to eq(4) }
    end

    describe 'updated data' do
      before { Artist.update_all(associated_act: 'The Super Band') }

      specify {
        expect(Artist.find(randy_rhoads).associated_act).to eq('The Super Band')
      }

      specify {
        expect(Artist.find(michael_amott).associated_act).to eq('The Super Band')
      }

      specify {
        expect(Artist.find(don_airey).associated_act).to eq('The Super Band')
      }

      specify {
        expect(Artist.find(zakk_wylde).associated_act).to eq('The Super Band')
      }
    end
  end

  describe '.pstore_key' do
    context Artist do
      subject { Artist.pstore_key }

      it { is_expected.to eq('Artist') }
    end
  end
end
