# -*- frozen-string-literal: true -*-

module ActivePStore
  module AttributeMethods
    def [](attr)
      if respond_to? attr.to_sym
        self.public_send(attr.to_sym)
      else
        raise "undefined method `#{attr}'"
      end
    end

    def []=(attr, value)
      if respond_to? "#{attr}=".to_sym
        self.public_send("#{attr}=".to_sym, value)
      else
        raise "undefined method `#{attr}='"
      end
    end
  end
end
