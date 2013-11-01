require "experimental_graph/version"
require 'rubygems'
require 'neography'
require_relative '../config/initializers/neography'

NEO = Neography::Rest.new

module ExperimentalGraph
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

  def method_missing(meth, *args, &blk)
    case meth
    when /^r_(.*)/ then NEO.create_relationship($1, *args)
    else super
    end
  end
end
