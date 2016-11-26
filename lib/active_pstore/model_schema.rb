# -*- frozen-string-literal: true -*-

module ActivePStore
  module ModelSchema
    def pstore_key
      self.to_s
    end

    alias table_name pstore_key
  end
end
