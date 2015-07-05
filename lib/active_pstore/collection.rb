module ActivePStore
  class Collection
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

    def count
      @objects.count
    end

    def empty?
      @objects.empty?
    end

    def method_missing(method_name, *args, &block)
      @objects.__send__(method_name, *args, &block)
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
