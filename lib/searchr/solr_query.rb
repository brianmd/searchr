module Searchr
  class SolrQuery < Query
    def query_parameters
      {
          start: start_row,
          rows: num_rows,
          q: query,
          qf: fields_to_query,
          wt: return_type,
          indent: indent?,
          debugQuery: debug_query?,
          defType: query_type,
      }
    end

    protected

    def default_query
      '*.*'
    end

    def default_query_type
      'edismax'
    end
  end
end