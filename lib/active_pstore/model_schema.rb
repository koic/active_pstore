module ActivePStore
  module ModelSchema
    def pstore_key
      self.to_s
    end
  end
end
