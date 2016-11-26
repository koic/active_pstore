# -*- frozen-string-literal: true -*-

require 'pstore'

module ActivePStore
  module ConnectionHandling
    def connection_config
      @@config.dup.freeze
    end

    def establish_connection(options)
      unless options.is_a? Hash
        raise ArgumentError, "You must specify at database configuration. Example: ActivePStore::Base.establish_connection(database: '/path/to/file')"
      end

      @@config = {database: (options[:database] || options['database']).to_s}

      @@db = PStore.new(@@config[:database])
    end

    def use_connection
      @@db.transaction do |pstore|
        yield pstore
      end
    rescue # uninitialized class variable @@db in ActivePStore::Base
      raise ActivePStore::ConnectionNotEstablished, "Raised when connection to the pstore file path could not been established (for example when ActivePStore.establish_connection(database: '/path/to/file') is given a nil object)."
    end
  end
end
