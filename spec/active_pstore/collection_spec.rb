# -*- frozen-string-literal: true -*-

describe ActivePStore::Collection do
  include_context 'Rock stars on stage'

  describe '#count' do
    let(:birth_date_is_nil) {
      Artist.new(
        name: 'Gary Moore',
        associated_act: 'Gary Moore',
        instrument: 'guitar',
        birth_date: nil
      )
    }

    before do
      birth_date_is_nil.save
    end

    context 'all artists' do
      context 'no args' do
        subject { Artist.count }

        it { is_expected.to eq 5 }
      end

      context 'with :all' do
        subject { Artist.count(:all) }

        it { is_expected.to eq 5 }
      end

      context 'with :birth_date' do
        subject { Artist.count(:birth_date) }

        it { is_expected.to eq 4 }
      end
    end

    context 'only guitarists' do
      context 'no args' do
        subject { Artist.where(instrument: 'guitar').count }

        it { is_expected.to eq 4 }
      end

      context 'with :all' do
        subject { Artist.where(instrument: 'guitar').count(:all) }

        it { is_expected.to eq 4 }
      end

      context 'with :birth_date' do
        subject { Artist.where(instrument: 'guitar').count(:birth_date) }

        it { is_expected.to eq 3 }
      end
    end
  end

  describe '#to_a' do
    let(:collection) { Artist.all }

    subject { collection.to_a }

    it { is_expected.to be_an(Array) }
    it { expect(subject.size).to eq(4) }
  end
end
