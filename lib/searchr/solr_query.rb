module Searchr
  class SolrQuery < Query
    def query_type
      'edismax'
    end

    protected

    def default_query
      '*.*'
    end
  end
end