describe ActivePStore::Calculations do
  include_context 'Rock stars on stage'

  let(:all_artist_ids) { Artist.all.map(&:id) }

  describe 'ActivePStore::Base.ids' do
    subject { Artist.ids }

    it { is_expected.to eq all_artist_ids }
  end

  describe 'ActivePStore::Collection#ids' do
    subject { Artist.all.ids }

    it { is_expected.to eq all_artist_ids }
  end
end
