module ActivePStore
  module Inheritance
    def new(*args)
      if self == Base
        raise NotImplementedError, "#{self} is an abstract class and cannot be instantiated."
      else
        super
      end
    end
  end
end
