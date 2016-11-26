# -*- frozen-string-literal: true -*-

require 'forwardable'

module ActivePStore
  module Querying
    extend Forwardable

    def_delegators :all, :update_all, :destroy_all, :count
  end
end
