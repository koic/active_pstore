module ActivePStore
  module Integration
    def to_param
      id && id.to_s
    end
  end
end
