describe ActivePStore::ConnectionHandling do
  include_context 'Rock stars on stage'

  describe '.connection_config' do
    let(:connection_config) {
      {database: '/tmp/active_pstore_test'}
    }

    subject { Artist.connection_config }

    it { is_expected.to eq connection_config }
    it { is_expected.to be_frozen }
  end

  describe '.establish_connection' do
    context 'database configuration NOT specified' do
      specify {
        expect { Artist.establish_connection('/path/to/file') }.to raise_error(ArgumentError)
      }
    end

    context 'connection to the pstore file path could not been established' do
      before do
        Artist.establish_connection(database: nil)
      end

      specify {
        expect { Artist.all }.to raise_error(ActivePStore::ConnectionNotEstablished)
      }
    end
  end
end
