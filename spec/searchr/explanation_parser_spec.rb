

def example
  ["",
   "0.6810742 = (MATCH) sum of:",
   "  0.6810742 = (MATCH) max of:",
   "    0.0122339865 = (MATCH) product of:",
   "      0.024467973 = (MATCH) sum of:",
   "        0.024467973 = (MATCH) weight(body:enron.com in 28270) [DefaultSimilarity], result of:",
   "          0.024467973 = score(doc=28270,freq=3.0 = termFreq=3.0",
   "), product of:",
   "            0.17022434 = queryWeight, product of:",
   "              2.6556184 = idf(docFreq=100470, maxDocs=526098)",
   "              0.0640997 = queryNorm",
   "            0.14373957 = fieldWeight in 28270, product of:",
   "              1.7320508 = tf(freq=3.0), with freq of:",
   "                3.0 = termFreq=3.0",
   "              2.6556184 = idf(docFreq=100470, maxDocs=526098)",
   "              0.03125 = fieldNorm(doc=28270)",
   "      0.5 = coord(1/2)",
   "    0.6810742 = (MATCH) product of:",
   "      1.3621484 = (MATCH) sum of:",
   "        1.3621484 = (MATCH) weight(subject:enron.com in 28270) [DefaultSimilarity], result of:",
   "          1.3621484 = score(doc=28270,freq=1.0 = termFreq=1.0",
   "), product of:",
   "            0.4178835 = queryWeight, product of:",
   "              6.5192738 = idf(docFreq=2108, maxDocs=526098)",
   "              0.0640997 = queryNorm",
   "            3.2596369 = fieldWeight in 28270, product of:",
   "              1.0 = tf(freq=1.0), with freq of:",
   "                1.0 = termFreq=1.0",
   "              6.5192738 = idf(docFreq=2108, maxDocs=526098)",
   "              0.5 = fieldNorm(doc=28270)",
   "      0.5 = coord(1/2)"
  ]
end

require 'searchr/explanation_parser'

describe Searchr::ExplanationParser do
  let!(:parser) { Searchr::ExplanationParser.new example }
  let!(:explanation) { parser.explanation }

  it 'explanation has right str' do
    expect(explanation.str).to eq(parser.top_node.simple_string)
  end

  it 'explanation has right nested' do
    expect(explanation.nested).to eq(parser.top_node.simple_json)
  end

  it 'explanation has right flattened' do
    expect(explanation.flattened).to eq(parser.top_node.simple_array)
  end

  xcontext 'show parsed values' do    # these cause errors, thereby showing the values
    it 'string' do
      # str = parser.top_node.simple_string
      str = explanation.str
      expect(str).to eq(3)
    end

    it 'nested' do
      # nested = parser.top_node.simple_json
      nested = explanation.nested
      expect(nested).to eq(3)
    end

    it 'array' do
      # flattened = parser.top_node.simple_array
      flattened = explanation.flattened
      expect(flattened).to eq(3)
    end
  end
end