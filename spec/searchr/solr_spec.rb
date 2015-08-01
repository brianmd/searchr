require 'spec_helper'

describe Searchr::Solr do
  it 'should have a uri' do
    expect(subject.uri.class).to be(URI::HTTP)
  end

  it 'can do a query' do
    expect(subject.search.class).to eq(Searchr::Result)
  end
end