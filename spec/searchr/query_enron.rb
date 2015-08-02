module Searchr
  class EnronQuery < SolrQuery

    protected

    def default_base_query_url
      "http://localhost:8983/solr/#{default_collection}/select"
    end

    def default_collection
      'collection1'
    end

    def default_query
      'phillip.allen@enron.com'
    end

    def default_fields_to_query
      'from
to
body^20
subject^20'
    end

    def default_fields_to_return
      'id from to subject date'
    end
  end
end
