require "experimental_graph/version"
require 'rubygems'
require 'neography'
require_relative '../config/initializers/neography'

NEO = Neography::Rest.new

module ExperimentalGraph
  class Neo4j
    def initialize
      @neo = Neography::Rest.new
    end

    # Cypher methods
    def query(q, opts = {})
      convert(@neo.execute_query(q, opts))
    end

    def batch(queries)
      args = queries.map { |q| [:execute_query, q] }
      @neo.batch(*args)
    end

    # Creation methods
    def node(args)
      Neography::Node.create(args)
    end

    def node_with_label(args, label_key)
      n = node(args)
      @neo.add_label(n, args[label_key.capitalize])
      n
    end

    # Accessing labels of a single node
    def labels_of(node)
      id = node.kind_of?(Fixnum) ? node : node.neo_id
      @neo.connection.get("/node/#{id}/labels")
    end

    def rel(type, outgoing, ingoing)
      Neography::Relationship.create(type, outgoing, ingoing)
    end

    # Node retrieval
    def get_node(node)
      Neography::Node.load(node)
    end

    def find
      # access the index
    end

    private

    def convert(result)
      return if result.nil?

      data = result['data']
      cols = result['columns']
      data.map do |row|
        row.each_with_index.each_with_object({}) do |(cell, i), hsh|
          hsh[cols[i]] = convert_cell(cell)
        end
      end
    end

    def convert_cell(cell)
      if cell['type']
        Neography::Relationship.new(cell)
      elsif cell['self']
        with_server(Neography::Node.new(cell))
      elsif cell.kind_of?(Enumerable)
        cell.map { |c| convert_cell(c) }
      else
        cell
      end
    end

    def with_server(node)
      node.neo_server = @neo
      node
    end
  end
  # Bunch of methods for easier node creation

  LABELS = %i{ person work lemma ethnos }
  LABELS.each do |label|
    self.class_eval <<-STR
      def #{label}(name)
        create_labeled(name, '#{label.capitalize}')
      end
    STR
  end

  def create_labeled(name, label)
    n = NEO.create_node('name' => name)
    NEO.add_label(n, label)
    NEO.add_node_to_index(label, label, name, n)
    n
  end

  def n(args)
    NEO.create_node(args)
  end

  # for additional properties

  def props(node, args)
    NEO.set_node_properties(node, args)
  end

  def label(node, label)
    NEO.add_label(node, label)
  end

  # and for relations

  def r(name, start_node, end_node)
    NEO.create_relationship(name, start_node, end_node)
  end

  def contains(container, content)
    r('contains', container, content)
  end

  def in_and_out(method, *nodes)
    send(method, *nodes)
    send(method, *nodes.reverse)
  end

  #def method_missing(meth, *args, &blk)
    #case meth
    #when /^r_(.*)/ then NEO.create_relationship($1, *args)
    #else super
    #end
  #end
end
