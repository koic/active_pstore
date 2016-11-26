# -*- frozen-string-literal: true -*-

module Rails
  module ActivePStore
    class Railtie < Rails::Railtie
      def self.rescue_responses
        {
          'ActivePStore::RecordNotFound' => :not_found
        }
      end

      if config.action_dispatch.rescue_responses
        config.action_dispatch.rescue_responses.merge!(rescue_responses)
      end

      initializer 'active_pstore.initialize_database' do
        config_file = Rails.root.join('config', 'active_pstore.yml')

        if config_file.file?
          require 'active_pstore/application/configuration'

          configuration = ::ActivePStore::Application::Configuration.new

          database = configuration.database_configuration.fetch(ENV['RAILS_ENV'] || 'development').fetch('database')

          ::ActivePStore::Base.establish_connection(database: database)
        end
      end
    end
  end
end
