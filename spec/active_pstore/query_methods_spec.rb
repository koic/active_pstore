require 'date'

describe ActivePStore::QueryMethods do
  include_context 'Rock stars on stage'

  describe '.where' do
    subject { Artist.where(conditions) }

    context 'exists data' do
      context 'have 1 condition' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne'} }

        it { is_expected.to match(ActivePStore::Collection.new([randy_rhoads, don_airey, zakk_wylde])) }
      end

      context 'have 2 conditions' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne', instrument: 'guitar'} }

        it { is_expected.to match(ActivePStore::Collection.new([randy_rhoads, zakk_wylde])) }
      end

      context 'array' do
        let(:conditions) { {name: ['Randy Rhoads', 'Don Airey']} }

        it { expect(subject[0]).to eq randy_rhoads }
        it { expect(subject[1]).to eq don_airey }
      end

      context 'date between' do
        let(:conditions) { {birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6)} }

        it { is_expected.to match(ActivePStore::Collection.new([randy_rhoads, zakk_wylde])) }
      end
    end

    context 'not found' do
      let(:conditions) { {} }

      before do
        Artist.destroy_all
      end

      it { is_expected.to be_empty }
    end
  end

  describe '.where.not' do
    subject { Artist.where.not(conditions) }

    context 'exists data' do
      context 'have 1 condition' do
        let(:conditions) { {associated_act: 'Arch Enemy'} }

        it { is_expected.to match(ActivePStore::Collection.new([randy_rhoads, don_airey, zakk_wylde])) }
      end

      context 'have 2 conditions' do
        let(:conditions) { {associated_act: 'Arch Enemy', instrument: 'keyboard'} }

        it { is_expected.to match(ActivePStore::Collection.new([randy_rhoads, zakk_wylde])) }
      end

      context 'array' do
        let(:conditions) { {name: ['Michael Amott', 'Zakk Wylde']} }

        it { expect(subject[0]).to eq randy_rhoads }
        it { expect(subject[1]).to eq don_airey }
      end

      context 'date between' do
        let(:conditions) { {birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6)} }

        it { is_expected.to match(ActivePStore::Collection.new([don_airey, michael_amott])) }
      end
    end

    context 'not found' do
      let(:conditions) { {} }

      before do
        Artist.destroy_all
      end

      it { is_expected.to be_empty }
    end
  end

  describe 'scoping' do
    let(:conditions) { {associated_act: 'Ozzy Osbourne', instrument: 'guitar'} }

    describe 'where(conditions).count' do
      subject { Artist.where(conditions).count }

      it { is_expected.to eq(2) }
    end

    describe 'where(conditions).update_all' do
      before { Artist.where(conditions).update_all(associated_act: 'The Super Band') }

      specify { expect(Artist.find(randy_rhoads).associated_act).to eq('The Super Band') }
      specify { expect(Artist.find(michael_amott).associated_act).to eq('Arch Enemy') }
      specify { expect(Artist.find(don_airey).associated_act).to eq('Ozzy Osbourne') }
      specify { expect(Artist.find(zakk_wylde).associated_act).to eq('The Super Band') }
    end

    describe 'where(conditions).destroy_all' do
      before { Artist.where(conditions).destroy_all }

      specify { expect(Artist.count).to eq(2) }

      specify { expect { Artist.find(randy_rhoads) }.to raise_error(ActivePStore::RecordNotFound) }
      specify { expect(Artist.find(michael_amott)).to be }
      specify { expect(Artist.find(don_airey)).to be }
      specify { expect { Artist.find(zakk_wylde) }.to raise_error(ActivePStore::RecordNotFound) }
    end
  end
end
