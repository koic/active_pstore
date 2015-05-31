module ActivePStore
  module Core
    def ==(comparison_object)
      if id
        comparison_object.instance_of?(self.class) && comparison_object.id == id
      else
        super
      end
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
