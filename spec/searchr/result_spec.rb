require 'spec_helper'

describe Searchr::SolrResult do
  before(:all) {
    @query = Searchr::EnronQuery.new
    @result = @query.search
  }

  it 'should succeed' do
    expect(@result.code).to eq(200)
  end
end
