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
    include ActivePStore::Core
    include ActivePStore::Persistence

    class << self
      def all
        use_connection {|connection|
          ActivePStore::Collection.new(connection[self.pstore_key] || [])
        }
      end
    end
  end
end
