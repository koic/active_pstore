describe ActivePStore::Collection do
  include_context 'Rock stars on stage'

  describe '#to_a' do
    let(:collection) { Artist.all }

    subject { collection.to_a }

    it { is_expected.to be_an(Array) }
    it { expect(subject.size).to eq(4) }
  end
end
