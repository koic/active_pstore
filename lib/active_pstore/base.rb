require 'pstore'
require 'securerandom'

module ActivePStore
  class Base
    attr_reader :id

    class << self
      def establish_connection(options = {})
        @@db = PStore.new(options[:database] || options['database'])
      end

      def find(id)
        id = id.is_a?(ActivePStore::Base) ? id.id : id

        all.find {|obj| obj.id == id } || (raise ActivePStore::RecordNotFound.new("Couldn't find #{self} with 'id'=#{id}"))
      end

      def all
        @@db.transaction do
          @@db[self.key]
        end
      end

      def first
        all.first
      end

      def last
        all.last
      end

      def find_by(conditions = {})
        where.first
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
        @@db.transaction do
          @@db[self.key] = []
        end
      end

      def count
        all.count
      end

      def key
        self.class.to_s
      end
    end

    def new_record?
      @id.nil?
    end

    def destroy
      @@db.transaction do
        @@db[self.class.key].delete_if {|obj| obj.id == self.id }
      end

      self
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

    def save
      @@db.transaction do
        if new_record?
          @id = SecureRandom.hex

          if @@db[self.class.key]
            @@db[self.class.key] << self
          else
            @@db[self.class.key] = [self]
          end
        else
          @@db[self.class.key].map! {|obj| obj.id == self.id ? self : obj }
        end
      end

      true
    end
  end
end
