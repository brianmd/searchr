module Searchr
  class SolrResult < Result
    def documents
      @documents ||= body['response']['docs']
    end

    def num_documents_received
      documents.size
    end

    def num_documents_requested
      query.num_rows
    end

    def start_row
      @start_row ||= body['response']['start']
    end

    def end_row
      start_row + num_documents_received - 1
    end

    def num_matches
      @num_found ||= body['response']['numFound']
    end

    def status
      status ||= body['responseHeader']['status']
    end

    def parameters
      @parameters ||= body['responseHeader']['params']
    end

    def explain
      body['debug']['explain']
    end

    # calculated fields

    def explanations
      explanation_hash
    end

    def explanation_hash
      unless @explanation_hash
        @explanation_hash = extract_explanations
        @explanation_hash.each do |key, rows|
          parser = ExplanationParser.new rows
          rows[0] = parser.explanation
        end
      end
      @explanation_hash
    end

    protected

    def extract_explanations
      matches = {}
      explain.each do |key, val|
        matches[key] = val.split("\n")
      end
      matches
    end
  end
end
