# -*- frozen-string-literal: true -*-

module ActivePstore
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc 'Creates a Active PStore configuration file at config/active_pstore.yml'

      def self.source_root
        File.expand_path('../templates', __FILE__)
      end

      def create_config_file
        template 'active_pstore.yml', File.join('config', 'active_pstore.yml')
      end
    end
  end
end
