class Tv < ApplicationRecord
	has_many :tvroles
	has_many :persons, through: :tvroles

	require 'date'
	require 'zlib'
	require 'stringio'
	require 'net/http'

	@apikey = File.read(Rails.root.join('config','apikey').to_s)

	def self.crawl_tv(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/tv/#{id}?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		id, name = data['id'], data['name']
		return {'id' => id, 'name' => name}
	end

	def self.crawl_tv_credit(id)
		data = Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/tv/#{id}/credits?api_key=#{@apikey}&language=en-US"))
		data = JSON.parse data
		cast, crew = data['cast'], data['crew']
		return cast + crew
	end

	def self.entire_tv_ids
		# yesterday date
		yesterday = Date.today.prev_day.to_s.tr('-','_')
		yesterday = yesterday[5..-1] + '_' + yesterday[0..3]
		tv_series_url = "http://files.tmdb.org/p/exports/tv_series_ids_#{yesterday}.json.gz"
		tv_series_ids = Net::HTTP.get(URI.parse(tv_series_url))
		tv_series_ids = Zlib::GzipReader.new(StringIO.new(tv_series_ids.to_s))

		output = []
		tv_series_ids.each do |i|
			output << JSON.parse(i)['id']
		end
		return output
	end


	def self.initializeDB
		entire_tv_ids.each do |id|
			data = crawl_tv(id)
			id, name = data['id'], data['name']
			tv = Tv.new({'id' => id, 'name' => name})
			tv.save
			puts tv.inspect
			# break
		end
	end

	def self.fastInitializeDB
		yesterday = Date.today.prev_day.to_s.tr('-','_')
		yesterday = yesterday[5..-1] + '_' + yesterday[0..3]
		tv_series_url = "http://files.tmdb.org/p/exports/tv_series_ids_#{yesterday}.json.gz"
		tv_series_ids = Net::HTTP.get(URI.parse(tv_series_url))
		tv_series_ids = Zlib::GzipReader.new(StringIO.new(tv_series_ids.to_s))

		tv_series_ids.each do |data|
			data = JSON.parse data
			id,name = data['id'], data['original_name']
			movie = Tv.new({'id' => id, 'name' => name})
			movie.save
			puts movie.inspect
		end
	end

end
