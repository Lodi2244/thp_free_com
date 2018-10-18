require 'dotenv'
require 'gmail'
require 'csv'
require 'base64'

class Mailer

	def initialize
		@lol = CSV.foreach("./db.csv")
		translate
		sendmail(translate, decoding)
	end

	def decoding

        	key = "dGhlaGFja2luZ3Byb2plY3QxMjM0"
        	key = Base64.strict_decode64(key)
        	return key
	end

	
	def translate
		
		array_email = Array.new
		array_nom_commun = Array.new
		@lol.each do |v|
			array_email << v[2].lstrip.rstrip
			array_nom_commun << v[1]
		end
 	 	final_hash = Hash[array_email.zip(array_nom_commun)]
		return final_hash
	end

	def sendmail(final_hash, key)


		gmail = Gmail.connect("roxy.foxy2244@gmail.com", "#{key}")
		final_hash.each do |k,v|
			email = gmail.compose do
				to "#{k}"
				subject "Bonjour"
				body  "Bonjour,
Je m'appelle élodie, je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 500 personnes sont passées par The Hacking Project. Est-ce que la mairie de #{v} veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80"
			end
			email.deliver!
		end
	end
end
