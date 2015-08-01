module Searchr
  class Query
    attr_writer :query, :fields_to_query, :start_row, :num_rows

    def query
      @query ||= default_query
    end

    def query_type
      @query_type ||= default_query_type
    end

    def fields_to_query
      @fields_to_query ||= default_fields_to_query
    end

    def start_row
      @start_row ||= 0
    end

    def num_rows
      @num_rows ||= default_num_rows
    end

    def indent?
      @do_indent ||= default_indent?
    end

    def debug_query?
      @do_debug_query ||= default_debug_query?
    end

    def return_type
      @return_type ||= default_return_type
    end

    def query_parameters
      subclass_responsibility
    end

    protected

    def default_query
      subclass_responsibility
    end

    def default_query_type
      subclass_responsibility
    end

    def default_fields_to_query
      subclass_responsibility
    end

    def default_num_rows
      10
    end

    def default_indent?
      # purely cosmetic to make it easier to read.
      true
    end

    def default_debug_query?
      # true required to diagnose result weights
      true
    end

    def default_return_type
      'json'
    end
  end
end