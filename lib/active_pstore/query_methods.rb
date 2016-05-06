module ActivePStore
  module QueryMethods
    class WhereChain
      def initialize(scope)
        @scope = scope
      end

      def not(conditions)
        WhereDecider.new(@scope).decide(conditions, :reject)
      end
    end

    class WhereDecider
      def initialize(scope)
        @scope = scope
      end

      def decide(conditions, method)
        raise 'Illegal method error.' unless %i(reject select).include? method

        return @scope if conditions.empty?

        conditions.each do |key, value|
          @scope = @scope.public_send(method) {|obj|
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
        WhereDecider.new(ret).decide(conditions, :select)
      end
    end
  end
end
