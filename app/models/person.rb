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
		id,name = data['id'],data['name']
		# puts {'id'=>id,'name'=>name,'department'=>department,'character'=>character,'job'=>job }
		return {'id'=>id,'name'=>name}
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

	def self.crawl_movie_credit(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/person/#{id}/movie_credits?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		# cast, crew = data['cast'], data['crew']
		# return cast + crew
		return data
	end

	def self.crawl_tv_credit(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/person/#{id}/tv_credits?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		# cast, crew = data['cast'], data['crew']
		# return cast + crew
		return data
	end

	def self.initializeDB
		entire_person_ids.each do |id|
			data = crawl_person(id)
			id,name = data['id'],data['name']
			person = Person.new({'id'=>id,'name'=>name})
			person.save
			puts person.inspect
			# break
		end
	end

	def self.fastInitializeDB
		entire_person_ids.each do |data|
			id,name = data['id'], data['name']
			movie = Person.new({'id' => id, 'name' => name})
			movie.save
			puts movie.inspect
		end
	end

end