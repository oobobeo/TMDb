require 'net/http'
require 'date'
require 'zlib'
require 'stringio'



def entire_tv_ids
	# apikey v3
	apikey = File.read('../config/apikey')

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

if __FILE__ == $0
	puts entire_tv_ids
end