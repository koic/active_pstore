describe ActivePStore::Calculations do
  include_context 'Rock stars on stage'

  let(:all_artist_ids) { Artist.all.map(&:id) }

  describe 'ActivePStore::Base.ids' do
    subject { Artist.ids }

    it { is_expected.to eq all_artist_ids }
  end

  describe 'ActivePStore::Collection#ids' do
    context 'only guitarists' do
      subject { Artist.where(instrument: 'guitar').ids }

      it { is_expected.to eq [randy_rhoads, michael_amott, zakk_wylde].map(&:id) }
    end
  end

  describe 'ActivePStore::Collection#minimum' do
    context 'all artists' do
      subject { Artist.minimum(:birth_date) }

      it { is_expected.to eq don_airey.birth_date }
    end

    context 'only guitarists' do
      subject { Artist.where(instrument: 'guitar').minimum(:birth_date) }

      it { is_expected.to eq zakk_wylde.birth_date }
    end
  end

  describe 'ActivePStore::Collection#maximum' do
    context 'all artists' do
      subject { Artist.maximum(:birth_date) }

      it { is_expected.to eq michael_amott.birth_date }
    end

    context 'only guitarists' do
      subject { Artist.where(instrument: 'guitar').maximum(:birth_date) }

      it { is_expected.to eq michael_amott.birth_date }
    end
  end
end
