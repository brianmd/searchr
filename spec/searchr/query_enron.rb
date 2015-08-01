module Searchr
  class EnronQuery < SolrQuery

    protected

    def default_query
      'phillip.allen@enron.com'
    end

    def default_fields_to_query
      'from
to
body^20
subject^20'
    end
  end
end
