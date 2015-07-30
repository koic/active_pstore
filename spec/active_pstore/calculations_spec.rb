describe ActivePStore::Calculations do
  include_context 'Rock stars on stage'

  describe '#ids' do
    subject { receiver.ids }

    context 'receiver is an ActivePStore::Collection' do
      let(:receiver) { Artist.all }

      it { is_expected.to eq receiver.map(&:id) }
    end
  end
end
