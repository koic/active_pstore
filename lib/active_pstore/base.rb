module ActivePStore
  class Base
    extend ActivePStore::ConnectionHandling
    extend ActivePStore::DynamicMatchers
    extend ActivePStore::FinderMethods
    extend ActivePStore::Inheritance
    extend ActivePStore::Querying
    extend ActivePStore::QueryMethods
    include ActivePStore::Core
    include ActivePStore::Persistence

    class << self
      def all
        use_connection do |connection|
          ActivePStore::Collection.new(connection[self.pstore_key] || [])
        end
      end

      def ids
        all.ids
      end

      def minimum(attr_name)
        all.minimum(attr_name)
      end

      def pstore_key
        self.to_s
      end
    end
  end
end
