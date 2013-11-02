require 'nokogiri'

class XmlParser
  CAESAR = File.read(File.expand_path('../../data/caesar.xml', __FILE__))

  def initialize
    @doc = Nokogiri::XML(CAESAR)
  end
end
