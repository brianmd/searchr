#require 'addressable/uri'
require 'net/http'

module Searchr
  class Solr
    attr_accessor :uri

    def initialize(uri=default_solr_uri)
      self.uri = URI(uri)
    end

    protected

    def default_solr_uri
      'http://localhost:8983/solr/enron/select'
    end
  end
end
