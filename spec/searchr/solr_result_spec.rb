require 'spec_helper'

describe Searchr::SolrResult do
  before(:all) {
    @query = Searchr::EnronQuery.new
    @result = @query.search
  }

  it 'should be of the right class' do
    expect(@result.class).to eq(Searchr::SolrResult)
  end

  it 'should have success code' do
    expect(@result.code).to eq(200)
  end

  it 'should have a lot of search results' do
    expect(@result.num_matches).to be >5000
  end

  it 'should have explanations' do
    expect(@result.explanations.size).to be >3
  end

  context 'first explanation' do
    let(:explanation) { @result.explanations.first }

    it 'should have two elements' do
      expect(explanation.size).to eq(2)
    end

    it 'first element should be a string' do
      expect(explanation[0].class).to eq(String)
    end

    it 'second element should be an array' do
      expect(explanation[1].class).to eq(Array)
      expect(explanation[1].size).to be >3
    end
  end
end
