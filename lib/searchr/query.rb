require 'addressable/uri'

module Searchr
  class Query
    attr_writer :query, :fields_to_query

    def search
      result_class.new self, http_response
    end

    def result_class
      subclass_responsibility
    end

    def http_response
      Net::HTTP.get_response url
    end

    def query
      @query ||= default_query
    end

    def query_type
      @query_type ||= default_query_type
    end

    def base_query_url
      @base_query_url ||= default_base_query_url
    end

    def fields_to_query
      @fields_to_query ||= default_fields_to_query
    end

    def fields_to_return
      @fields_to_return ||= default_fields_to_return
      @fields_to_return.gsub(/\s+/m, ' ').strip.split(" ")
    end

    def fields_to_return=(array_or_string)
      @fields_to_return = if array_or_string.class==String
                            array_or_string
                          else
                            array_or_string.join(' ')
                          end
    end

    def start_row
      @start_row ||= 0
    end

    def start_row=(num)
      num_as_int = Integer(num)
      raise "start_row must be a positive integer (#{num})" if num_as_int < 0
      @start_row = num_as_int
    end

    def num_rows
      @num_rows ||= default_num_rows
    end

    def num_rows=(num)
      num_as_int = Integer(num)
      raise "num_rows must be a positive integer (#{num})" if num_as_int < 0
      @num_rows = num_as_int
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

    def url
      uri = URI(base_query_url)

      query_uri = Addressable::URI.new
      query_uri.query_values = query_parameters

      uri.query = query_uri.query
      uri
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

    def default_fields_to_return
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