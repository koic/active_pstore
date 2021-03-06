# -*- frozen-string-literal: true -*-

module ActivePStore; end

require 'active_pstore/attribute_methods'
require 'active_pstore/calculations'
require 'active_pstore/collection'
require 'active_pstore/connection_handling'
require 'active_pstore/core'
require 'active_pstore/delegation'
require 'active_pstore/dynamic_matchers'
require 'active_pstore/finder_methods'
require 'active_pstore/inheritance'
require 'active_pstore/integration'
require 'active_pstore/model_schema'
require 'active_pstore/persistence'
require 'active_pstore/query_methods'
require 'active_pstore/querying'
require 'active_pstore/base'
require 'active_pstore/errors'

if defined?(Rails)
  require 'active_pstore/railtie'
end
