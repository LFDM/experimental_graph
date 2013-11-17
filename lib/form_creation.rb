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

  def create_forms(forms, with_stem = false)
    nodes = create_nodes(forms)
    lemma_string = forms.first.to_s
    lemma = find_or_create_lemma(lemma_string)
    nodes.zip(forms).each do |node, form|
      create_morphological_edges(node, form, lemma, with_stem)
    end
  end

  # this will only work with nouns at the moment
  def create_morphological_edges(node, form , lemma, with_stem)
    lemma.outgoing(:form) << node
    edges = edges_through_type(form)
    target = target_of_morph_edges(form, lemma, with_stem)
    edges.each do |edge|
      val = normalized_val(form, edge)
      target.outgoing(val) << node
    end
  end

  def normalized_val(form, edge)
    val = form.send(edge)
    norm_values = t.norm_values_for(edge)
    abbr_values = t.norm_values_for(edge, format: :abbr)
    Hash[norm_values.zip(abbr_values)][val]
  end

  def target_of_morph_edges(form, lemma, with_stem)
    if with_stem
      stem = find_or_create_distinct_node(:stem, form.stem)
      handle_stem_edge(stem, lemma)
      stem
    else
      lemma
    end
  end

  def handle_stem_edge(stem, lemma)
    # don't create an edge if its already here
    lemma.outgoing(:stem) << stem
  end

  def edges_through_type(form)
    case form.class.name
    when /Noun$/ then %i{ casus numerus sexus }
    end
  end

  def find_or_create_distinct_node(type, string)
    index = type.to_s
    n = @neo.find(index, string).first
    return n if n
    create_distinct_node(string)
  end

  def create_distint_node(type, string)
    index = type.to_s
    label = index.capitalize
    n = @neo.node_with_label(label, name: string)
    @neo.add_index(l, index, string)
    n
  end

  def create_nodes(forms)
    forms.map do |form|
      node = @neo.node_with_label('Form', string: form.to_s)
      @neo.add_index(node, 'form', 'string', form.to_s)
      node
    end
  end
end
