require 'securerandom'

module ActivePStore
  module Persistence
    attr_reader :id

    def new_record?
      @id.nil?
    end

    def save
      ActivePStore::Base.use_connection do |connection|
        if new_record?
          @id = SecureRandom.hex

          if connection[self.class.pstore_key]
            connection[self.class.pstore_key] << self
          else
            connection[self.class.pstore_key] = [self]
          end
        else
          connection[self.class.pstore_key].map! {|obj| obj.id == self.id ? self : obj }
        end
      end

      true
    end

    def update_attribute(attr_name, attr_value)
      self.__send__("#{attr_name}=", attr_value)

      save
    end

    def update_attributes(attrs)
      attrs.each do |attr_name, attr_value|
        self.__send__("#{attr_name}=", attr_value)
      end

      save
    end
  end
end
