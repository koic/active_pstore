module ActivePStore
  class Base
    extend ActivePStore::ConnectionHandling
    extend ActivePStore::FinderMethods
    extend ActivePStore::Inheritance
    extend ActivePStore::QueryMethods
    include ActivePStore::Persistence

    class << self
      def all
        use_connection do |connection|
          connection[self.pstore_key] || []
        end
      end

      def update_all(attrs)
        all.each {|obj|
          obj.update_attributes(attrs)
        }.count
      end

      def destroy_all
        all.inject(0) {|result, obj|
          obj.destroy

          result += 1
        }
      end

      def count
        all.count
      end

      def pstore_key
        self.to_s
      end
    end
  end
end
