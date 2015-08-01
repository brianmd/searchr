require 'spec_helper'

describe Searchr::EnronQuery do
  it 'should have start row' do
    expect(subject.start_row).to eq(0)
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
end