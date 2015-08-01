require 'spec_helper'
require_relative 'solr_enron'

describe Searchr::SolrEnron do
  it 'should have a uri' do
    expect(subject.uri.class).to be(URI::HTTP)
  end

  it 'can do a query' do
    expect(subject.search.class).to eq(Searchr::Result)
  end
end