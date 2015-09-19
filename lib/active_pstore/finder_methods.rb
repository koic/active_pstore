module ActivePStore
  module FinderMethods
    def find(*ids)
      if ids.size == 1
        id = ids.first
        id = id.is_a?(ActivePStore::Base) ? id.id : id

        all.find {|obj| obj.id == id } || (raise ActivePStore::RecordNotFound, "Couldn't find #{self} with 'id'=#{id}")
      else
        ret = ids.each_with_object([]) {|id, ret|
          id = id.is_a?(ActivePStore::Base) ? ids.id : id

          ret << all.find {|obj| obj.id == id }
        }.compact

        raise ActivePStore::RecordNotFound, "Couldn't find all #{self} with 'id': (#{ids.join(', ')}) (found #{ret.size} results, but was looking for #{ids.size})" unless ret.size == ids.size

        ret
      end
    end

    def find_by(conditions = {})
      where(conditions).first
    end

    def find_by!(conditions = {})
      find_by(conditions) || (raise ActivePStore::RecordNotFound, "Couldn't find #{self} with conditions=#{conditions}")
    end

    def first
      all.first
    end

    def last
      all.last
    end

    def take(limit = nil)
      limit ? all.take(limit) : first
    end
  end
end
