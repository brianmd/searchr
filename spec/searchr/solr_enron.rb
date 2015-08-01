module Searchr
  class SolrEnron < Solr

    protected

    def default_solr_uri
      'http://localhost:8983/solr/collection1/select'
    end
  end
end