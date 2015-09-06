require 'active_model'

module ActivePStore
  class Base
    extend ActivePStore::ConnectionHandling
    extend ActivePStore::DynamicMatchers
    extend ActivePStore::FinderMethods
    extend ActivePStore::Inheritance
    extend ActivePStore::ModelSchema
    extend ActivePStore::QueryMethods
    extend ActivePStore::Querying
    extend ActivePStore::Delegation
    include ActiveModel::Model
    include ActivePStore::AttributeMethods
    include ActivePStore::Core
    include ActivePStore::Integration
    include ActivePStore::Persistence

    def initialize(attributes = nil)
      if attributes.present?
        attributes.each do |attr, val|
          if respond_to? "#{attr}=".to_sym
            self.__send__("#{attr}=", val)
          else
            raise "undefined method `#{attr}='"
          end
        end
      end

      yield self if block_given?
    end

    class << self
      alias build new

      def all
        use_connection {|connection|
          ActivePStore::Collection.new(connection[self.pstore_key] || [])
        }
      end

      def create(attributes = nil, &block)
        if attributes.is_a?(Array)
          attributes.map {|attr| create(attr, &block) }
        else
          build(attributes, &block).tap do |obj|
            obj.save
          end
        end
      end

      def first_or_create(attributes = nil, &block)
        first || create(attributes, &block)
      end

      def find_or_create_by(attributes, &block)
        find_by(attributes) || create(attributes, &block)
      end

      def find_or_initialize_by(attributes, &block)
        find_by(attributes) || new(attributes, &block)
      end
    end
  end
end
