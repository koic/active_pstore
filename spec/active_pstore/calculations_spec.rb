describe ActivePStore::Calculations do
  include_context 'Rock stars on stage'

  describe '#ids' do
    let(:artists) { Artist.all }

    subject { artists.ids }

    it { is_expected.to eq artists.map(&:id) }
  end
end
