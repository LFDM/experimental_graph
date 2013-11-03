require 'nokogiri'

class XmlParser
  CAESAR = File.read(File.expand_path('../../data/caesar.xml', __FILE__))

  def initialize
    @doc = Nokogiri::XML(CAESAR)
    @neo = Neo4j.new
  end

  def parse
    sentences.each do |sentence|
      sent_id = extract_attribute(sentence, :id, :to_i)
      sent_node = @neo.get_node(sent_id)
      words = words_of(sentence)
      tokens = create_tokens(words)
      add_dependency_relations(sent_node, words, tokens)
    end
  end

  def add_dependency_relations(sent_node, words, tokens)
    relations = extract_relations(words)
    tokens.each do |token|
      head, rel = relations[token.index]
      # the form with head 0 == the root node connects itself to the sentence
      head_token = find_by_index(tokens, head) || sent_node
      puts "Creating relation #{rel} from #{token.string}"
      sent_node.outgoing(:contains) << token
      head_token.outgoing(rel) << token
    end
  end

  def find_by_index(tokens, index)
    tokens.find { |token| token.index == index }
  end

  def extract_relations(words)
    words.each_with_object({}) do |word, hsh|
      id = extract_attribute(word, :id, :to_i)
      head = extract_attribute(word, :head, :to_i)
      rel  = extract_attribute(word, :relation)
      hsh[id] = [head, rel.to_sym]
    end
  end

  def create_tokens(words)
    words.map do |word|
      id = extract_attribute(word, :id, :to_i)
      string = extract_attribute(word, :form)
      puts "Creating token: #{string}, #{id}"
      create_token(string, id)
    end
  end

  def create_token(string, id)
    @neo.node_with_label('Token', string: string, index: id)
  end

  def extract_attribute(elem, attr, formatter = nil)
    val = elem.attributes[attr.to_s].value
    formatter ? val.send(formatter) : val
  end

  def words_of(sentence)
    sentence.xpath('//word')
  end

  def sentences
    @doc.xpath('/sentence')
  end
end
