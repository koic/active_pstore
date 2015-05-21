require 'pstore'

module ActivePStore
  class Base
    CONFIG_PATH = '/tmp/foo'

    @@db = PStore.new(CONFIG_PATH)

    class << self
      def all
        @@db.transaction do
          @@db[self.key]
        end
      end

      def destroy_all
        @@db = PStore.new(CONFIG_PATH)

        @@db.transaction do
          @@db[self.key] = []
        end
      end

      def key
        self.class.to_s
      end
    end

    def save
      @@db.transaction do
        if @@db[self.class.key]
          @@db[self.class.key] << self
        else
          @@db[self.class.key] = [self]
        end
      end
    end
  end
end
