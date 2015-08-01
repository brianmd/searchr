module Searchr
  class Result
    attr_reader :query

    def initialize(query, http_response)
      @query = query
      @http_response = http_response
      raise 'Http response for search did not succeed' if code!=200
    end

    def body
      @body ||= JSON.parse(@http_response.body)
    end

    def code
      @http_response.code.to_i
    end

    def body_str
      @http_response.body
    end
  end
end