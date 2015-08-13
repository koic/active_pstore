describe ActivePStore::ModelSchema do
  include_context 'Rock stars on stage'

  describe '.pstore_key' do
    context Artist do
      subject { Artist.pstore_key }

      it { is_expected.to eq('Artist') }
    end
  end

  describe '.table_name' do
    context Artist do
      subject { Artist.table_name }

      it { is_expected.to eq('Artist') }
    end
  end
end
