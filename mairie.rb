require 'rubygems'
require 'nokogiri' 
require 'open-uri'
# require 'pry'

# page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))   
# puts page.class 
# => Nokogiri::HTML::Document

# méthode pour récupérer l'adresse email d'une page web de mairie
def gets_the_email_of_townhall_from_its_webpage(url)
	page = Nokogiri::HTML(open(url))
	emails = page.css("tr td.style27 p.Style22 font") # array emails regroupant les éléments dont le chemin a été précisé
	emails.each do |i| # itération sur l'array pour obtenir l'élément i
		if i.text.include?"@" # si le texte de l'élément i contient @
			return i.text # on affiche le texte de l'élément i
		end
	end
end

# méthode pour récupérer les url et ranger dans un Hash les paires Ville / emails
def get_all_the_urls_of_valdoise_townhalls
		town_hash = Hash.new # création du Hash town_hash
		page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
		urls = page.css("a.lientxt") # on définit une variable urls qui renvoie à un array des a de classe lientxt
		urls.each do |url| # itération sur l'array pour obtenir l'élément url
			clean_url = "http://annuaire-des-mairies.com"+url['href'][1..url['href'].length] # clean url est un string concaténé de http://...et de l'attribut href de l'élément url sans son premier caractère
			town_hash[url.text] = gets_the_email_of_townhall_from_its_webpage(clean_url) # classement dans le hash
		end
		return town_hash
end
print get_all_the_urls_of_valdoise_townhalls

# si l'on écrit tout dans une seule méthode
=begin
def get_all_the_urls_of_valdoise_townhalls
		page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
		urls = page.css("a.lientxt")
		urls.each do |url|
			# puts "http://annuaire-des-mairies.com#{url['href']}"
			clean_url = "http://annuaire-des-mairies.com"+url['href'][1..url['href'].length]
			page = Nokogiri::HTML(open(clean_url))
			emails = page.css("tr td.style27 p.Style22 font")
			emails.each do |email| 
				if email.text.include?"@"
				puts email.text
				end
			end
		end
end
get_all_the_urls_of_valdoise_townhalls
=end

# example d'url d'une mairie
# "http://annuaire-des-mairies.com/95/vaureal.html"
# gets_the_email_of_townhall_from_its_webpage(clean_url)
# puts "http://annuaire-des-mairies.com#{url['href']}"

