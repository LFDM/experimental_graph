require 'nokogiri'

class XmlParser
  CAESAR_PATH = File.expand_path('..data/caesar.xml', __FILE__)

  def initialize
    @doc = Nokogiri::XML(CAESAR_PATH)
    require 'pry'; binding.pry
  end
end
