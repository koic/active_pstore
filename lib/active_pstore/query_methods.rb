module ActivePStore
  module QueryMethods
    class WhereChain
      def initialize(scope)
        @scope = scope
      end

      def not(conditions)
        return @scope if conditions.empty?

        conditions.each do |key, value|
          @scope = @scope.reject {|obj|
            case value
            when Array, Range
              value.include?(obj.public_send(key))
            else
              obj.public_send(key) == value
            end
          }
        end

        ActivePStore::Collection.new(@scope)
      end
    end

    def where(conditions = :chain)
      ret = all

      if conditions == :chain
        WhereChain.new(ret)
      else
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
end
