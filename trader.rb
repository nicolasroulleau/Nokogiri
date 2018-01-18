require 'rubygems'
require 'nokogiri' 
require 'open-uri'
# require 'pry'

# page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/vaureal.html"))   
# puts page.class 
# => Nokogiri::HTML::Document

array_of_prices_hash = []
i = 0

def get_crypto_prices
	prices_hash = Hash.new
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))	
	rows = page.css('tbody tr') #on définit une variable rows qui renvoie un array de tous les tr dans tbody (= lignes du tableau) 
	rows.each do |row| #on va chercher le prix et le symbole dans chaque ligne
		columns = row.css('td') #les colonnes sont les sélecteurs td 
		prices_hash[columns[2].text.to_sym] = columns[4].css('a').text
		#on prend le symbole de la crypto (3e colonne) que l'on transforme en symbole, puis on lui attribue le prix (5e colonne et contenu dans un a)
	end
	return prices_hash
end

#on ajoute un prices_hash toutes les heures pendant 24h
while i < 23
	#on exécute la méthode get_crypto_prices
	array_of_prices_hash << get_crypto_prices
	print array_of_prices_hash
	#on attend une heure
	sleep(3600)
	i += 1
	#on recommence :) 
end