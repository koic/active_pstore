module ActivePStore
  class Base
    extend ActivePStore::ConnectionHandling
    extend ActivePStore::FinderMethods
    extend ActivePStore::Inheritance
    include ActivePStore::Persistence

    class << self
      def all
        use_connection do |connection|
          connection[self.pstore_key] || []
        end
      end

      def where(conditions = {})
        ret = all

        return ret if conditions.empty?

        conditions.each do |key, value|
          ret = ret.select {|obj|
            if value.is_a? Range
              value.include?(obj.__send__(key))
            else
              obj.__send__(key) == value
            end
          }
        end

        ret
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
