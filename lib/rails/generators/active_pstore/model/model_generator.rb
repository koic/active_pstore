# -*- frozen-string-literal: true -*-

module ActivePstore
  module Generators
    class ModelGenerator < Rails::Generators::NamedBase
      desc 'Creates a Active PStore model'
      argument :attributes, type: :array, default: [], banner: 'attribute_name_1 attribute_name_2'

      def self.source_root
        File.expand_path('../templates', __FILE__)
      end

      def create_model_file
        template 'model.rb.tt', File.join('app/models', class_path, "#{file_name}.rb")
      end
    end
  end
end
