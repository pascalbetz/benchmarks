require 'benchmark/ips'
require 'nokogiri'
require 'ox'
require 'oga'
require 'rexml/document'


xml = DATA.read

ox = Ox.parse(xml)
nokogiri = Nokogiri::XML(xml)
oga = Oga.parse_xml(xml)
rex = REXML::Document.new xml

Benchmark.ips do |x|
  x.report('Nokogiri: NodeSet') do
    map = []
    nokogiri.css('record').each do |node|
      map << node.children
    end
    map

    map.each do |node|
      node.css('attr1').inner_text
      node.css('attr2').inner_text
      node.css('attr3').inner_text
      node.css('attr4').inner_text
    end
  end

  x.report('Nokogiri: Element') do
    nokogiri.css('record').each do |node|
      node.css('attr1').inner_text
      node.css('attr2').inner_text
      node.css('attr3').inner_text
      node.css('attr4').inner_text
    end
  end

  x.report('OX') do
    ox.locate('record').each do |node|
      node.locate('attr1').first.text
      node.locate('attr2').first.text
      node.locate('attr3').first.text
      node.locate('attr4').first.text
    end
  end

  x.report('OGA') do
    oga.xpath('//record') do |node|
      node.at_xpath('attr1').text
      node.at_xpath('attr2').text
      node.at_xpath('attr3').text
      node.at_xpath('attr4').text
    end
  end

  x.report('REXML') do
    rex.elements.each('*/record') do |node|
      node.elements['attr1'].text
      node.elements['attr2'].text
      node.elements['attr3'].text
      node.elements['attr4'].text
    end
  end
end


__END__
<root>
  <record>
    <attr1>bla1</attr1>
    <attr2>bla2</attr2>
    <attr3>bla3</attr3>
    <attr4>bla4</attr4>
  </record>
  <record>
    <attr1>bla1</attr1>
    <attr2>bla2</attr2>
    <attr3>bla3</attr3>
    <attr4>bla4</attr4>
  </record>
</root>
