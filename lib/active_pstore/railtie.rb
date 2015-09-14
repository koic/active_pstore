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

      # Loads and returns the entire raw configuration of database from
      # values stored in `config/active_pstore.yml`.
      def database_configuration
        yaml = Pathname.new('config/active_pstore.yml')

        config = if yaml && yaml.exist?
          require 'yaml'
          require 'erb'
          YAML.load(ERB.new(yaml.read).result) || {}
        else
          raise 'Could not load database configuration. No such file - config/active_pstore.yml'
        end

        config
      rescue Psych::SyntaxError => e
        raise "YAML syntax error occurred while parsing config/active_pstore.yml. " \
              "Please note that YAML must be consistently indented using spaces. Tabs are not allowed. " \
              "Error: #{e.message}"
      rescue => e
        raise e, "Cannot load `Rails::ActivePStore::Railtie.database_configuration`:\n#{e.message}", e.backtrace
      end

      initializer 'active_pstore.initialize_database' do
        config_file = Rails.root.join('config', 'active_pstore.yml')

        if config_file.file?
          database = database_configuration.fetch(ENV['RAILS_ENV'] || 'development').fetch('database')

          ::ActivePStore::Base.establish_connection(database: database)
        end
      end
    end
  end
end
