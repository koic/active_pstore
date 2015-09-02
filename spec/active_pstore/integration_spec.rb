describe ActivePStore::Integration do
  include_context 'Rock stars on stage'

  describe '#to_param' do
    subject { randy_rhoads.to_param }

    it { is_expected.to eq randy_rhoads.id }
  end
end
