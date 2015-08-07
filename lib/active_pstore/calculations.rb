module ActivePStore
  module Calculations
    def ids
      map(&:id)
    end

    def minimum(attr_name)
      map(&attr_name.to_sym).min
    end
  end
end
