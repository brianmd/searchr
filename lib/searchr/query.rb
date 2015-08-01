module Searchr
  class Query
    attr_writer :query, :fields_to_query, :start_row, :num_rows

    def query
      @query ||= default_query
    end

    def fields_to_query
      @fields_to_query ||= default_fields_to_query
    end

    def start_row
      @start_row ||= 0
    end

    def num_rows
      @num_rows ||= 10
    end

    protected

    def default_query
      subclass_responsibility
    end

    def default_fields_to_query
      subclass_responsibility
    end
  end
end