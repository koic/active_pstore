# -*- frozen-string-literal: true -*-

module ActivePStore
  class Collection
    include ActivePStore::Calculations

    def initialize(objects)
      @objects = objects
    end

    def update_all(updates)
      @objects.each {|obj|
        obj.update_attributes(updates)
      }.count
    end

    def destroy_all
      @objects.inject(0) {|result, obj|
        obj.destroy

        result += 1
      }
    end

    def count(attr_name = nil)
      if attr_name.nil? || attr_name == :all
        @objects.count
      else
        @objects.map(&attr_name.to_sym).compact.count
      end
    end

    def empty?
      @objects.empty?
    end

    def method_missing(method_name, *args, &block)
      @objects.public_send(method_name, *args, &block)
    end

    def ==(comparison_object)
      comparison_object.instance_of?(self.class) && self.map(&:id) <=> comparison_object.map(&:id)
    end
    alias :eql? :==

    def hash
      if id
        id.hash
      else
        super
      end
    end
  end
end
