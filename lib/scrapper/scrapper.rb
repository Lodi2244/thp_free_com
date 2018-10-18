require 'nokogiri'
require 'open-uri'
require 'csv'
require 'rubocop'

# On fait une class pour lancer tout le scrapping
# pout le Bas-Rhin et l'Ille et vilaire, deux pages sont nécessaire pour afficher toutes les communes,
# nous sommes donc obligé de lancer deux fois le programme
class TownhallRun
  def initialize
    puts "Attention le programme est long il tourne pendant 45 min"
    url_bas_rhin_01 = TownhallScrapper.new('http://annuaire-des-mairies.com/bas-rhin.html',67,'Bas-Rhin')
    url_bas_rhin_01.perform
    url_bas_rhin_02 = TownhallScrapper.new('http://annuaire-des-mairies.com/bas-rhin-2.html',67,'Bas-Rhin')
    url_bas_rhin_02.perform
    url_ille_et_villaine_01 = TownhallScrapper.new('http://www.annuaire-des-mairies.com/ille-et-vilaine.html',35,'Ille-et-Vilaine')
    url_ille_et_villaine_01.perform
    url_ille_et_villaine_02 = TownhallScrapper.new('http://www.annuaire-des-mairies.com/ille-et-vilaine-2.html',35,'Ille-et-Vilaine')
    url_ille_et_villaine_02.perform
    url_haut_de_seine = TownhallScrapper.new('http://www.annuaire-des-mairies.com/hauts-de-seine.html',92,'Hauts-de-Seine')
    url_haut_de_seine.perform
  end
end

# on créer une class qui vient récupérer l'intégralité des emails d'un
# departement en partant de l'annuaire du site "http://www.annuaire-des-mairies.com/"
class TownhallScrapper

  attr_accessor :url, :department_number, :department_name

# A l'initialisation on a simplement besoin de l'url du departement,
# le numero du departement et son nom 
  def initialize(url,department_number,department_name)
    @url = url
    @department_number = department_number.to_s
    @department_name = department_name.to_s
  end

# cette fonction à partir de l'url correspondant à la commune sort l'adresse email s'il en a pas on l'identifie en mettant aucun email
  def get_the_mail_of_a_townhal_from_its_webpage(url_of_the_page)
    page_01 = Nokogiri::HTML(open(url_of_the_page))
    text = page_01.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text 
    if text != "" 
      return text 
    else 
      return "AUCUN EMAIL" 
    end
  end

# cette fonction à partir de l'url correspondant à la commune sort le nom de la commune 
  def get_the_name_of_a_townhal_from_its_webpage(url_of_the_page)
    page_01 = Nokogiri::HTML(open(url_of_the_page))
    name_of_town = page_01.search('td').map { |s| s.text.strip.encode('UTF-16be', :invalid => :replace, :replace => '?').encode('UTF-8') }
    .map { |x| x if /Insee/ =~ x }.join.gsub('Code Insee de ', '')    
  end

# cette fonction récupère toutes les urls des communes d'un département
  def get_all_the_urls_of_department_townhalls
    url_of_departement = Nokogiri::HTML(open(@url.to_s).read)
    array_of_townhalls = []
    url_of_departement.xpath('//tr//a/@href').each do |element|
      array_of_townhalls << element.text
    end
    array_of_townhalls = array_of_townhalls.select { |s| s.include?(@department_number) }.map { |t| t.gsub(/^./, '') }.map { |u| 'http://annuaire-des-mairies.com' + u }
  end

# cette fonction fait un tableau qui se remplit de la manière suivant [Département,nom de la commune,email]
  def get_all_email_of_department_townhalls
    get_all_the_urls_of_department_townhalls
    i = 0
    j = get_all_the_urls_of_department_townhalls.length.to_i
    town_city_name = []
    town_city_mail = []
    town_city_department = []
    while i < j
      town_city_mail       << get_the_mail_of_a_townhal_from_its_webpage(get_all_the_urls_of_department_townhalls[i])
      town_city_name       << get_the_name_of_a_townhal_from_its_webpage(get_all_the_urls_of_department_townhalls[i])
      town_city_department << @department_name
      i += 1
    end
    department_info = town_city_department.zip(town_city_name,town_city_mail)
  end

# cette fonction envoie le tableau dans un fichier csv
  def perform
    get_all_email_of_department_townhalls
    CSV.open("thp_free_com/db/db.csv","a+") {|csv| get_all_email_of_department_townhalls.to_a.each {|elem| csv << elem} }
    puts "done envoyé vers un csv"
  end
end


