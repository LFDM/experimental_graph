require 'rubygems'
require 'neography'
require_relative '../config/initializers/neography'

class Neo4j
  attr_reader :neo

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

  def rel(type, outgoing, ingoing)
    Neography::Relationship.create(type, outgoing, ingoing)
  end

  def node_with_label(label, args)
    n = node(args)
    @neo.add_label(n, label)
    n
  end

  def add_label(node, label)
    n = get_node(node)
    @neo.add_label(n, label)
  end

  def add_index(node, index, key = index, val)
    n = get_node(node)
    n.add_to_index(index, key, val)
  end

  # Accessing labels of a single node
  def labels_of(node)
    id = get_node(node).neo_id
    @neo.connection.get("/node/#{id}/labels")
  end

  # Node retrieval
  def get_node(node)
    Neography::Node.load(node)
  end

  def find(index, key = index, value)
    hashes = @neo.find_node_index(index, key, value)
    hashes.map { |hsh| get_node(hsh) }
  end

  def get_labeled(label)
    @neo.get_nodes_labeled(label)
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
      # need to add the server by hand, otherwise
      # traversing with this node fails
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
