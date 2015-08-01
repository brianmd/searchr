module Searchr
  class SolrResult < Result
    def num_matches
      @num_found ||= body['response']['numFound']
    end

    def explanations
      @explanation = extract_explanations
    end

    protected

    def extract_explanations
      matches = {}
      explain.each do |key, val|
        matches[key] = val.split("\n")
      end
      matches
    end

    def explain
      body['debug']['explain']
    end
  end
end
