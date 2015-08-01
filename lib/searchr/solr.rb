class Solr
  def self.default_solr_uri
    'http://localhost:8983/solr/enron/select'
  end

  def initialize(uri=default_solr_uri)
    @uri = uri
  end
end