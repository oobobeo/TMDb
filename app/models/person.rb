class Person < ApplicationRecord
	has_many :movieroles
	has_many :movies, through: :movieroles

	has_many :tvroles
	has_many :tvs, through: :tvroles

	require 'net/http'
	require 'date'
	require 'zlib'
	require 'stringio'

	@apikey = File.read(Rails.root.join('config','apikey').to_s)

	def self.crawl_person(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/person/#{id}?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		id,name,depertment,character,job = data['id'],data['name'],data['department'],data['character'],data['job']
		# puts {'id'=>id,'name'=>name,'department'=>department,'character'=>character,'job'=>job }
		return {'id'=>id,'name'=>name,'department'=>department,'character'=>character,'job'=>job }
	end

	def self.entire_person_ids
		# yesterday date
		yesterday = Date.today.prev_day.to_s.tr('-','_')
		yesterday = yesterday[5..-1] + '_' + yesterday[0..3]
		
		person_ids_url = "http://files.tmdb.org/p/exports/person_ids_#{yesterday}.json.gz"
		person_ids = Net::HTTP.get(URI.parse(person_ids_url))
		person_ids = Zlib::GzipReader.new(StringIO.new(person_ids.to_s))

		output = []
		person_ids.each do |i|
			output << JSON.parse(i)['id']
		end
		return output
	end

	def self.initializeDB(person_ids)
		person_ids.each do |data|
			data = JSON.parse data
			id,name,depertment,character,job = data['id'],data['name'],data['department'],data['character'],data['job']
			person = Person.new({'id'=>id,'name'=>name,'department'=>department,'character'=>character,'job'=>job })
			person.save
			puts person.inspect
			break
		end
	end
	
end
