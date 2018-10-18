require 'nokogiri'
require 'open-uri'

class Townhallscrapper

  attr_accessor :url, :department_number, :department_name

  def initialize(url,department_number,department_name)
    @url = url
    @department_number = department_number.to_s
    @department_name = department_name.to_s
  end

  def url_to_s
    @url.to_s
  end

  def get_the_mail_of_a_townhal_from_its_webpage(url_of_the_page)
    page_01 = Nokogiri::HTML(open(url_of_the_page))
    text = page_01.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text #Récupère l'email
    if text != "" #Si il y a un email
      return text #Le retourner
    else #Sinon
      return "AUCUN EMAIL" #Retourner "AUCUN EMAIL"
    end
  end

  def get_the_name_of_a_townhal_from_its_webpage(url_of_the_page)
    page_01 = Nokogiri::HTML(open(url_of_the_page))
    name_of_town = page_01.search('td').map { |s| s.text.strip.encode('UTF-16be', :invalid => :replace, :replace => '?').encode('UTF-8') }
    .map { |x| x if /Insee/ =~ x }.join.gsub('Code Insee de ', '')    
  end

  def get_all_the_urls_of_department_townhalls
    url_of_departement = Nokogiri::HTML(open(@url.to_s).read)
    array_of_townhalls = []
    url_of_departement.xpath('//tr//a/@href').each do |element|
      array_of_townhalls << element.text
    end
    array_of_townhalls = array_of_townhalls.select { |s| s.include?(@department_number) }.map { |t| t.gsub(/^./, '') }.map { |u| 'http://annuaire-des-mairies.com' + u }
  end

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

      puts town_city_department[i]
      puts town_city_name[i]
      puts town_city_mail[i]
      i += 1
    end
    town_city_name_and_email_adress = Hash.new 
    town_city_name_and_email_adress.zip(town_city_department,town_city_name,town_city_mail)
    puts town_city_name_and_email_adress
    #town_city_name_and_email_adress
  end

end

url_01 = Townhallscrapper.new('http://annuaire-des-mairies.com/bas-rhin.html',67,'Bas-Rhin')
url_01.get_all_email_of_department_townhalls

