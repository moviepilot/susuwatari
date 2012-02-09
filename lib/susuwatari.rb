require 'json'
require 'hashie'
require 'rest_client'
require 'forwardable'

require 'susuwatari/version'
require 'susuwatari/error'
require "susuwatari/result"
require 'susuwatari/client'

module Susuwatari
  def self.new(params)
    Susuwatari::Client.new(params)
  end
end
