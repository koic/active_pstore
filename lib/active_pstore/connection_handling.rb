require 'pstore'

module ActivePStore
  module ConnectionHandling
    def establish_connection(options = {})
      @@db = PStore.new((options[:database] || options['database']).to_s)
    end

    def use_connection
      @@db.transaction do |pstore|
        yield pstore
      end
    rescue # uninitialized class variable @@db in ActivePStore::Base
      raise ActivePStore::ConnectionNotEstablished.new(
       "Raised when connection to the pstore file path could not been established (for example when ActivePStore.establish_connection(database: '/path/to/file') is given a nil object)."
      )
    end
  end
end
