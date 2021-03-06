require 'spec_helper'

describe Searchr::EnronQuery do
  it 'should have start row' do
    expect(subject.start_row).to eq(1)
  end

  it 'should have num rows' do
    expect(subject.num_rows).to eq(10)
  end

  it 'should have a query' do
    expect(subject.query).to eq('phillip.allen@enron.com')
  end

  it 'should have fields to query' do
    expect(subject.fields_to_query).to match(/subject/)
  end

  it 'should have good query parameters' do
    params = subject.query_parameters
    expect(params[:rows]).to eq(10)
  end

  it 'should create a reasonable url' do
    expect(subject.url.to_s).to match(/edismax/)
  end

  it 'should get raw result' do
    results = subject.http_response
    expect(results.code).to eq('200')
    expect(results.body).to match(/"response"/)
    expect(results.body).to match(/"numFound"/)
    expect(results.body).to match(/"docs"/)
  end

  it 'should get solr result' do
    results = subject.search
    expect(results.code).to eq(200)
    expect(results.body_str).to match(/"response"/)
    expect(results.body_str).to match(/"numFound"/)
    expect(results.body_str).to match(/"docs"/)
  end
end