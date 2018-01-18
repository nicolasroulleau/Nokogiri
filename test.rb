require 'rubygems'
require 'nokogiri' 
require 'open-uri'

page = Nokogiri::HTML(open("http://ruby.bastardsbook.com/files/hello-webpage.html"))   

puts page.class   
# => Nokogiri::HTML::Document

news_links = page.css("div#references a")
puts news_links
# => <a href="http://www.google.com">Click here</a>
# => <a href="http://www.bing.com">click here to go</a>
# => <a href="http://learnpythonthehardway.org/">Zed Shaw's Learn Python the Hard Way</a>
news_links.each{|link| puts "#{link.text}\t#{link['href']}"}
# => Click here	http://www.google.com
# => click here to go	http://www.bing.com
# => Zed Shaw's Learn Python the Hard Way	http://learnpythonthehardway.org/

page = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/HTML"))
page.css('div#content div#bodyContent table.infobox tr th').each do |el|
   puts el.text
end
# => Filename extension
# => Internet media type
# => Type code
# => Developed by
# => Initial release
# => Latest release
# => Type of format
# => Extended from
# => Extended to
# => Standards
# => Open format?
# => Website

