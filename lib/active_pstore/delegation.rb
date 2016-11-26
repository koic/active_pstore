# -*- frozen-string-literal: true -*-

require 'forwardable'

module ActivePStore
  module Delegation
    extend Forwardable

    def_delegators :all, :ids, :count, :minimum, :maximum
  end
end
