module ActivePStore
  module Querying
    def update_all(attrs)
      all.update_all(attrs)
    end

    def destroy_all
      all.destroy_all
    end

    def count
      all.count
    end

    def emtpy?
      all.empty?
    end
  end
end
