module ActivePStore
  module FinderMethods
    def find(id)
      id = id.is_a?(ActivePStore::Base) ? id.id : id

      all.find {|obj| obj.id == id } || (raise ActivePStore::RecordNotFound.new("Couldn't find #{self} with 'id'=#{id}"))
    end

    def find_by(conditions = {})
      where.first
    end

    def find_by!(conditions = {})
      find_by(conditions) || (raise ActivePStore::RecordNotFound.new("Couldn't find #{self} with conditions=#{conditions}"))
    end

    def first
      all.first
    end

    def last
      all.last
    end
  end
end
