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
person_ids_url = "http://files.tmdb.org/p/exports/person_ids_#{yesterday}.json.gz"

person_ids = Net::HTTP.get(URI.parse(person_ids_url))

person_ids = Zlib::GzipReader.new(StringIO.new(person_ids.to_s))

output = []
person_ids.each do |i|
	output << JSON.parse(i)['id']
end
puts output