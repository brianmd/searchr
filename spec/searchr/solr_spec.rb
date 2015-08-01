require 'spec_helper'

describe Searchr::SolrEnron do
  it 'should have a uri' do
    expect(subject.uri.class).to be(URI::HTTP)
  end

  xit 'can do a query' do
    expect(subject.search.class).to eq(Searchr::Result)
  end
end
