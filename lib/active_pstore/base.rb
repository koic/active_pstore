require 'forwardable'

module ActivePStore
  class Base
    extend ActivePStore::ConnectionHandling
    extend ActivePStore::DynamicMatchers
    extend ActivePStore::FinderMethods
    extend ActivePStore::Inheritance
    extend ActivePStore::Querying
    extend ActivePStore::QueryMethods
    extend ActivePStore::ModelSchema
    include ActivePStore::Core
    include ActivePStore::Persistence

    extend SingleForwardable

    def_delegators :all, :ids, :count, :minimum, :maximum

    class << self
      def all
        use_connection do |connection|
          ActivePStore::Collection.new(connection[self.pstore_key] || [])
        end
      end
    end
  end
end
