require 'forwardable'

module ActivePStore
  class Base
    extend ActivePStore::ConnectionHandling
    extend ActivePStore::DynamicMatchers
    extend ActivePStore::FinderMethods
    extend ActivePStore::Inheritance
    extend ActivePStore::ModelSchema
    extend ActivePStore::QueryMethods
    extend ActivePStore::Querying
    extend SingleForwardable
    include ActivePStore::Core
    include ActivePStore::Persistence

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
