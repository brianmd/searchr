module Searchr
  Explanation = Struct.new(:str, :nested, :flattened)

  class ExplanationParser
    attr_reader :lines

    def initialize(lines)
      @lines = lines.select{ |line| !line.empty? }.collect{ |line| ExplainLine.new line }
    end

    def explanation
      Explanation.new top_node.simple_string, top_node.simple_json, top_node.simple_array
    end

    def top_node
      @top_node ||= scrunch
    end

    private

    def scrunch
      @_nodes = Array.new(20)
      @_nodes[0] = @lines[0].node(nil)
      @_node_depth = 0
      @_line_num = 1
      process_next_line until eof?

      return @_nodes[0]
    end

    def parent_node
      @_nodes[line.indent_level - 1]
    end
    def line
      @lines[@_line_num]
    end

    def set_current_node(node, depth)
      @_node_depth = depth
      @_nodes[depth] = node
    end

    def process_next_line
      node = line.node parent_node
      set_current_node node, line.indent_level
      bump_line
      consume_subordinate_lines node if node.is_leaf
    end

    def bump_line
      @_line_num += 1
    end

    def eof?
      @_line_num >= @lines.size
    end

    def consume_subordinate_lines(node)
      current_line = line
      bump_line
      while !eof? and (line.indent_level==0 or current_line.indent_level<line.indent_level)
        node.add_line "#{'  '*[line.indent_level-current_line.indent_level,0].max}#{line.line}"
        bump_line
      end
    end
  end

  class ExplainLine
    attr_reader :indent_level, :line

    def self.node(str)
      self.new(str).node
    end

    def initialize(line)
      num_spaces = (/^\s*/.match line).to_s.size
      @indent_level = num_spaces / 2
      @line = line[num_spaces..line.size]
    end

    def node(parent)
      line_type.new parent, self
    end

    def line_type
      return ProductNode if @line.include? ') product of:'
      return SumNode     if @line.include? ') sum of:'
      return MaxNode     if @line.include? ') max of:'
      return WeightNode  if @line.include? ') weight('
      return CoordNode   if @line.include? '= coord('
      msg = "Unknown line type: #{@line}"
      msg.logit
      raise msg
    end

    def score
      @score ||= line.to_f
    end
  end

  module Node
    attr_reader :parent, :explain_line

    def initialize(parent, explain_line)
      set_parent parent
      @explain_line = explain_line
    end

    def score
      @explain_line.score
    end

    def children
      @children ||= []
    end

    def is_leaf
      false
    end

    private

    def set_parent(parent)
      @parent = parent
      @parent.children << self if parent
    end
  end

  class ProductNode
    include Node

    def simple_string
      case children.size
      when 0
        ''
      when 1
        children[0].simple_string
      else
        "#{score}=(" + (children.collect {|child| child.simple_string}.join(" * ")) + ")"
      end
    end

    def simple_json
      case children.size
      when 0
        nil
      when 1
        children[0].simple_json
      else
        [score, '*', children.collect {|child| child.simple_json}.select {|ele| !ele.nil?}]
      end
    end

    def simple_array
      results = children.collect {|child| child.simple_array}
      case results.size
      when 0
        []
      when 1
        results[0]
      else
        ['(', ['*', score]] + results.flatten(1) + [')']
      end
    end
  end

  class SumNode
    include Node

    def simple_string
      case children.size
      when 0
        ''
      when 1
        children[0].simple_string
      else
        "#{score}=(" + (children.collect {|child| child.simple_string}.join(" + ")) + ")"
      end
    end


    def simple_json
      case children.size
      when 0
        nil
      when 1
        children[0].simple_json
      else
        [score, '+', children.collect {|child| child.simple_json}.select {|ele| !ele.nil?}]
      end
    end

    def simple_array
      results = children.collect {|child| child.simple_array}
      case results.size
      when 0
        []
      when 1
        results[0]
      else
        ['(', ['+', score]] + results.flatten(1) + [')']
      end
    end
  end

  class MaxNode
    include Node

    def simple_string
      case children.size
      when 0
        ''
      when 1
        children[0].simple_string
      else
        "#{score}=max(" + (children.collect {|child| child.simple_string}.join(", ")) + ")"
      end
    end


    def simple_json
      case children.size
      when 0
        nil
      when 1
        children[0].simple_json
      else
        [score, 'max', children.collect {|child| child.simple_json}.select {|ele| !ele.nil?}]
      end
    end

    def simple_array
      results = children.collect {|child| child.simple_array}
      case results.size
      when 0
        []
      when 1
        results[0]
      else
        ['(', ['max', score]] + results.flatten(1) + [')']
      end
    end
  end

  class WeightNode
    include Node

    def is_leaf
      true
    end

    def weight_name
      m = /\) weight\(([^)]+)/.match explain_line.line
      m[1]
    end

    def add_line(line)
      subordinate_rows << line
    end

    def subordinate_rows
      @subordinate_rows ||= []
    end

    def simple_string
      "[#{score}=#{weight_name}]"
    end

    def simple_json
      [score, weight_name, subordinate_rows]
    end

    def simple_array
      [[weight_name, score, subordinate_rows]]
    end
  end

  class CoordNode
    include Node

    def simple_string
      "[#{score}=coord]"
    end

    def simple_json
      [score, 'coord']
    end

    def simple_array
      [['coord', score]]
    end
  end
end