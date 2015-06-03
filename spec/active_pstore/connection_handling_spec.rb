describe ActivePStore::ConnectionHandling do
  include_context 'Rock stars on stage'

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
