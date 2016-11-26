# -*- frozen-string-literal: true -*-

module ActivePStore
  module Application
    class Configuration
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
    end
  end
end
