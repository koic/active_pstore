describe ActivePStore::Core do
  include_context 'Rock stars on stage'

  let(:randy) { Artist.find(randy_rhoads) }

  describe '#==' do
    subject { randy == randy_rhoads }

    it { is_expected.to be true }
  end

  describe '#hash' do
    subject { randy.hash }

    it { is_expected.to eq randy_rhoads.id.hash }
  end
end
