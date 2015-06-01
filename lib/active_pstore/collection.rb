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
  end
end
