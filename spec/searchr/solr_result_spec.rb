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

  it 'should know number of rows' do
    expect(@result.num_documents_requested).to eq(10)
  end

  it 'should have a lot of search results' do
    expect(@result.num_matches).to be >5000
  end

  it 'should have 10 documents' do
    expect(@result.documents.size).to eq(10)
    expect(@result.num_documents_received).to eq(10)
  end

  it 'should have explanations' do
    expect(@result.explanations.keys.size).to be >3
  end

  context 'first explanation' do
    let(:explanation) { @result.explanations.first[1] }

    it 'should have many elements' do
      expect(explanation.size).to be >5
    end

    it 'first element should be an explanation' do
      expect(explanation[0].class).to eq(Searchr::Explanation)
    end

    it 'second element should be a string' do
      expect(explanation[1].class).to eq(String)
      expect(explanation[1].size).to be >3
    end
  end
end
