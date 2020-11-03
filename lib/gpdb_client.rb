require 'active_support/core_ext/module'
require 'jwt'
require 'faraday'

require 'gpdb'
require 'gpdb/credentials'
require 'gpdb/configuration'
require 'gpdb/http_client'
require 'gpdb/model'
require 'gpdb/version'

require 'gpdb/rest/base_resource'
require 'gpdb/rest/client'
require 'gpdb/rest/request'
require 'gpdb/rest/response'

require 'gpdb/rest/recording_request/model'
require 'gpdb/rest/recording_request/resource'
require 'gpdb/rest/recording_request/response'

require 'gpdb/rest/pronunciation/model'
require 'gpdb/rest/pronunciation/resource'
require 'gpdb/rest/pronunciation/response'
require 'gpdb/rest/pronunciation/target'
require 'gpdb/rest/pronunciation/target_response'
require 'gpdb/rest/pronunciation/target_list_response'

module GpdbClient; end
