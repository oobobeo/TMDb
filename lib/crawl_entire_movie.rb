require 'net/http'
require 'date'
require 'zlib'
require 'stringio'

# apikey v3
apikey = File.read('config/apikey')

# yesterday date
yesterday = Date.today.prev_day.to_s.tr('-','_')
yesterday = yesterday[5..-1] + '_' + yesterday[0..3]

# get today's TMDb exports
movie_ids_url = "http://files.tmdb.org/p/exports/movie_ids_#{yesterday}.json.gz"

movie_ids = Net::HTTP.get(URI.parse(movie_ids_url))

movie_ids = Zlib::GzipReader.new(StringIO.new(movie_ids.to_s))

output = []
movie_ids.each do |i|
	output << JSON.parse(i)['id']
end
puts output