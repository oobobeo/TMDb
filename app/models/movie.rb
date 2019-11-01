class Movie < ApplicationRecord
	has_many :movieroles
	has_many :persons, through: :movieroles


	require 'date'
	require 'zlib'
	require 'stringio'
	require 'net/http'
	@apikey = File.read(Rails.root.join('config','apikey').to_s)

	def self.crawl_movie(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/movie/#{id}?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		id, title = data['id'], data['original_title']
		return {'id' => id, 'title' => title}
	end

	def self.crawl_movie_credit(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/movie/#{id}/credits?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		cast, crew = data['cast'], data['crew']
		return cast + crew
	end

	def self.entire_movie_ids
		# yesterday date
		yesterday = Date.today.prev_day.to_s.tr('-','_')
		yesterday = yesterday[5..-1] + '_' + yesterday[0..3]
		movie_ids_url = "http://files.tmdb.org/p/exports/movie_ids_#{yesterday}.json.gz"
		movie_ids = Net::HTTP.get(URI.parse(movie_ids_url))
		movie_ids = Zlib::GzipReader.new(StringIO.new(movie_ids.to_s))

		output = []
		movie_ids.each do |i|
			output << JSON.parse(i)['id']
		end
		return output
	end


	def self.initializeDB
		entire_movie_ids.each do |id|
			data = crawl_movie(id)
			id, title = data['id'], data['original_title']
			movie = Movie.new({'id' => id, 'title' => title})
			movie.save
			puts movie.inspect
			# break
		end
	end

	def self.fastInitializeDB
		yesterday = Date.today.prev_day.to_s.tr('-','_')
		yesterday = yesterday[5..-1] + '_' + yesterday[0..3]
		movie_ids_url = "http://files.tmdb.org/p/exports/movie_ids_#{yesterday}.json.gz"
		movie_ids = Net::HTTP.get(URI.parse(movie_ids_url))
		movie_ids = Zlib::GzipReader.new(StringIO.new(movie_ids.to_s))

		counter = 0
		movie_ids.each do |data|
			data = JSON.parse data
			id,title = data['id'], data['original_title']
			movie = Movie.new({'id' => id, 'title' => title})
			movie.save
			puts movie.inspect
			counter = 0
			if counter % 100 == 0
				puts movie.inspect
			end
			counter += 1
		end
	end

	def self.changed_ids
		url = "https://api.themoviedb.org/3/movie/changes?api_key=#{@apikey}&page=1"
		data = Net::HTTP.get(URI.parse(url))
		data = JSON.parse data
		output = []
		data['results'].each do |d|
			output << d['id']
		end
		return output
	end

	def self.updateDB
		ids = changed_ids
		ids.each do |id|
			data = crawl_movie(id)
			id,title = data['id'], data['title']
			Movie.update(id,'title'=>title)
		end
	end
end
