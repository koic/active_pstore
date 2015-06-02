require 'spec_helper'

describe ActivePStore::FinderMethods do
  include_context 'Rock stars on stage'

  describe '.find' do
    subject { Artist.find(id) }

    shared_examples_for 'fishing with a pole' do
      context 'exists data' do
        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end

      context 'not found' do
        let(:id) { '9' * 32 }

        before do
          Artist.destroy_all
        end

        it { expect { subject }.to raise_error(ActivePStore::RecordNotFound, "Couldn't find Artist with 'id'=#{id}") }
      end
    end

    it_behaves_like 'fishing with a pole' do
      let(:id) { randy_rhoads.id }
    end

    it_behaves_like 'fishing with a pole' do
      let(:id) { randy_rhoads }
    end
  end

  describe '.first' do
    subject { Artist.first }

    context 'exists data' do
      it { is_expected.to be_an(Artist) }
      it { expect(subject.name).to eq('Randy Rhoads') }
    end

    context 'empty data' do
      before do
        Artist.destroy_all
      end

      it { is_expected.to be_nil }
    end
  end

  describe '.last' do
    subject { Artist.last }

    context 'exists data' do
      it { is_expected.to be_an(Artist) }
      it { expect(subject.name).to eq('Zakk Wylde') }
    end

    context 'empty data' do
      before do
        Artist.destroy_all
      end

      it { is_expected.to be_nil }
    end
  end

  shared_examples_for 'find_by series' do
    context 'exists data' do
      context 'have 1 condition' do
        let(:conditions) { {associated_act: 'Arch Enemy'} }

        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Michael Amott') }
      end

      context 'have 2 conditions' do
        let(:conditions) { {associated_act: 'Ozzy Osbourne', instrument: 'guitar'} }

        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end

      context 'date between' do
        let(:conditions) { {birth_date: Date.new(1948, 12, 3)..Date.new(1956, 12, 6)} }

        it { is_expected.to be_an(Artist) }
        it { expect(subject.name).to eq('Randy Rhoads') }
      end
    end
  end

  describe '.find_by' do
    subject { Artist.find_by(conditions) }

    it_behaves_like 'find_by series'

    context 'not found' do
      let(:conditions) { {} }

      before do
        Artist.destroy_all
      end

      it { is_expected.to be_nil }
    end
  end

  describe '.find_by!' do
    subject { Artist.find_by!(conditions) }

    it_behaves_like 'find_by series'

    context 'not found' do
      let(:conditions) { {} }

      before do
        Artist.destroy_all
      end

      it { expect { subject }.to raise_error(ActivePStore::RecordNotFound, "Couldn't find Artist with conditions=#{conditions}") }
    end
  end

  describe '.take' do
    context 'with argument' do
      subject { Artist.take(2) }

      it { expect(subject.size).to eq 2 }
      it { expect(subject[0].name).to eq randy_rhoads.name }
      it { expect(subject[1].name).to eq michael_amott.name }
    end

    context 'without argument' do
      subject { Artist.take }

      it { expect(subject.name).to eq randy_rhoads.name }
    end
  end
end
