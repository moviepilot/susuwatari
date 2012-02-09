module Susuwatari
  class Client
    extend Forwardable

    attr_accessor :params, :response

    def_delegator :@result, :status

    TEST_URL = 'http://www.webpagetest.org/runtest.php'

    def initialize( params = {} )
      params.fetch(:k)
      params.fetch(:url)
      params[:f] = :json
      params[:runs] ||= 1
      params.delete(:r)
      self.params = params
    end

    def run
      return status if @result
      @result = Result.new(make_request)
      @result.test_id
    end

    def result
      @result && @result.test_result || {}
    end

    def status
      @result && @result.status || :to_be_run
    end

    private

    def make_request
      response = RestClient.get TEST_URL, :params => params, :accept => :json
      raise_error "The requests was not completed, try again." unless  response.code == 200
      body     = Hashie::Mash.new(JSON.parse(response.body))
      raise_error(body.statusText) unless body.statusCode == 200
      body
    end

    def raise_error(msg)
      raise Error.new(msg)
    end
  end
end
