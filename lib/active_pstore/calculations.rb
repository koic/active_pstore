module ActivePStore
  module Calculations
    def ids
      map(&:id)
    end

    def minimum(attr_name)
      map(&attr_name.to_sym).min
    end

    def maximum(attr_name)
      map(&attr_name.to_sym).max
    end
  end
end
