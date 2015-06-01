module ActivePStore
  module QueryMethods
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

      ActivePStore::Collection.new(ret)
    end
  end
end
