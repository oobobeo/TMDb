class Movie < ApplicationRecord
	has_and_belongs_to_many :persons



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


	def self.initializeDB(movie_ids)
		movie_ids.each do |data|
			data = JSON.parse data
			id, title = data['id'], data['original_title']
			# How do I save movie data???
			movie = Movie.new({'id' => id, 'title' => title})
			movie.save
			puts movie.inspect
			break
		end
	end
end
