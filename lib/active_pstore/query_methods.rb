module ActivePStore
  module QueryMethods
    def where(conditions = {})
      ret = all

      return ret if conditions.empty?

      conditions.each do |key, value|
        ret = ret.select {|obj|
          case value
          when Array, Range
            value.include?(obj.public_send(key))
          else
            obj.public_send(key) == value
          end
        }
      end

      ActivePStore::Collection.new(ret)
    end
  end
end
