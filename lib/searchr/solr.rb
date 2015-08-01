require 'net/http'

module Searchr
  class Solr
    attr_accessor :uri

    def initialize(uri=default_solr_uri)
      self.uri = URI(uri)
    end

    def search
      Result.new
    end

    protected

    def default_solr_uri
      'http://localhost:8983/solr/collection1/select'
    end
  end
end
