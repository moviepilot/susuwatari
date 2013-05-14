require 'active_support/core_ext/hash/conversions'
require 'active_support/inflections'

require 'csv'

module Susuwatari
  class Result
    extend Forwardable

    STATUS_URL        = 'http://www.webpagetest.org/testStatus.php'
    RESULT_URL_PREFIX = 'http://www.webpagetest.org/jsonResult.php?test='

    attr_reader :test_id, :current_status, :test_result, :request_raw

    def_delegators :@test_result, :average, :median

    def initialize( request_response )
      @request_raw = request_response
      @test_id  = request_raw.data.testId
    end

    def status
      fetch_status unless current_status == :complete
      current_status
    end

    private

    def fetch_status
      status = Hashie::Mash.new(JSON.parse( RestClient.get STATUS_URL, :params => { :f => :json, :test => test_id }))
      case status.data.statusCode.to_s
      when /1../
        @current_status = :running
      when "200"
        @current_status = :completed
        fetch_result
      when /4../
        @current_status = :error
      end
    end

    def fetch_result
      response = RestClient.get "#{RESULT_URL_PREFIX}#{test_id}"
      @test_result  = Hashie::Mash.new(JSON.parse(response)).data
    end

  end
end
