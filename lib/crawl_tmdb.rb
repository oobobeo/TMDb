require 'net/http'
require 'date'
require 'zlib'
require 'stringio'
require_relative '../app/controllers/persons_controller.rb'
require_relative '../app/controllers/movies_controller.rb'
require_relative '../app/controllers/tvs_controller.rb'

# apikey v3
apikey = File.read('config/apikey')

# yesterday date
yesterday = Date.today.prev_day.to_s.tr('-','_')
yesterday = yesterday[5..-1] + '_' + yesterday[0..3]

# get today's TMDb exports
movie_ids_url = "http://files.tmdb.org/p/exports/movie_ids_#{yesterday}.json.gz"
person_ids_url = "http://files.tmdb.org/p/exports/person_ids_#{yesterday}.json.gz"
tv_series_url = "http://files.tmdb.org/p/exports/tv_series_ids_#{yesterday}.json.gz"

# send request
movie_ids = Net::HTTP.get(URI.parse(movie_ids_url))
person_ids = Net::HTTP.get(URI.parse(person_ids_url))
tv_series_ids = Net::HTTP.get(URI.parse(tv_series_url))

# unzip
movie_ids = Zlib::GzipReader.new(StringIO.new(movie_ids.to_s))
person_ids = Zlib::GzipReader.new(StringIO.new(person_ids.to_s))
tv_series_ids = Zlib::GzipReader.new(StringIO.new(tv_series_ids.to_s))


PersonsController.initializeDB(person_ids)
MoviesController.initializeDB(movie_ids)
TvsController.initializeDB(tv_series_ids)


# # get movie
# result = Net::HTTP.get(URI.parse('http://api.themoviedb.org/3/movie/3924?api_key=f3acc58c5bbbdcf2d9025c4614bbf3dc&language=en-US'))
# # puts result
# result = JSON.parse result
# puts result['title']

