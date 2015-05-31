require 'spec_helper'
require 'date'

describe ActivePStore::Base do
  include_context 'Rock stars on stage'

  describe '.where' do
    subject { Artist.where(conditions) }

    context 'exists data' do
      context 'have 1 condition' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne'} }

        it { is_expected.to be_an(Array) }
        it { expect(subject.size).to eq(3) }
        it { expect(subject[0].name).to eq('Randy Rhoads') }
        it { expect(subject[1].name).to eq('Don Airey') }
        it { expect(subject[2].name).to eq('Zakk Wylde') }
      end

      context 'have 2 conditions' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne', instrument: 'guitar'} }

        it { is_expected.to be_an(Array) }
        it { expect(subject.size).to eq(2) }
        it { expect(subject[0].name).to eq('Randy Rhoads') }
        it { expect(subject[1].name).to eq('Zakk Wylde') }
      end

      context 'date between' do
        let(:conditions) { {birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6)} }

        it { is_expected.to be_an(Array) }
        it { expect(subject.size).to eq(2) }
        it { expect(subject[0].name).to eq('Randy Rhoads') }
        it { expect(subject[1].name).to eq('Zakk Wylde') }
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
end
