# -*- frozen-string-literal: true -*-

module ActivePStore
  module FinderMethods
    def find(*ids)
      ids = ids.map {|id| id.is_a?(ActivePStore::Base) ? id.id : id }

      _find(*ids).tap do |ret|
        if ids.size == 1
          raise ActivePStore::RecordNotFound, "Couldn't find #{self} with 'id'=#{ids.first}" if ret.nil?
        else
          raise ActivePStore::RecordNotFound, "Couldn't find all #{self} with 'id': (#{ids.join(', ')}) (found #{ret.size} results, but was looking for #{ids.size})" unless ret.size == ids.size
        end
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

    private

    def _find(*ids)
      if ids.size == 1
        id = ids.first

        all.find {|obj| obj.id == id }
      else
        ids.each_with_object([]) {|id, ret|
          ret << _find(id)
        }.compact
      end
    end
  end
end
