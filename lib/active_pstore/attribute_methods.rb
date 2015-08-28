module ActivePStore
  module AttributeMethods
    def [](attr)
      if respond_to? attr.to_sym
        self.__send__(attr.to_sym)
      else
        raise "undefined method `#{attr}'"
      end
    end
  end
end
