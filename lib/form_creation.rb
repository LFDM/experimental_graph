require 'llt/form_builder'

class FormCreation
  # seed data
  require_relative '../data/form_creation'

  include LLT::Helpers::Normalizer

  def initialize(builder = LLT::FormBuilder)
    @builder = builder
    @neo     = Neo4j.new
  end

  def execute(*args)
    create_forms(build(*args))
  end

  def build(*args)
    @builder.build(*args)
  end

  def create_forms(forms)
    nodes = create_nodes(forms)
    lemma_string = forms.first.to_s
    lemma = find_or_create_lemma(lemma_string)
    nodes.zip(forms).each do |node, form|
      create_morphological_edges(node, form, lemma)
    end
  end

  def create_morphological_edges(node, form , lemma)
    lemma.outgoing(:form) << node
    edges = edges_through_type(form)
    edges.each do |edge|
      val = normalized_val(form, edge)
      lemma.outgoing(val) << node
    end
  end

  def normalized_val(form, edge)
    val = form.send(edge)
    norm_values = t.norm_values_for(edge)
    abbr_values = t.norm_values_for(edge, format: :abbr)
    Hash[norm_values.zip(abbr_values)][val]
  end

  def edges_through_type(form)
    case form.class.name
    when /Noun$/ then %i{ casus numerus sexus }
    end
  end

  def find_or_create_lemma(lemma_string)
    l = @neo.find('lemma', lemma_string).first
    return l if l
    create_lemma(lemma_string)
  end

  def create_lemma(lemma_string)
    l = @neo.node_with_label('Lemma', name: lemma_string)
    l.add_index(l, 'lemma', lemma_string)
    l
  end

  def create_nodes(forms)
    forms.map do |form|
      node = @neo.node_with_label('Form', string: form.to_s)
      @neo.add_index(node, 'form', 'string', form.to_s)
      node
    end
  end
end
