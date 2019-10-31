require 'net/http'

def person
	apikey = File.read('config/apikey')

	result = []
	ARGV.each do |id|
		result << Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/person/#{id}?api_key=#{apikey}&language=en-US"))
	end
	return result
end

if __FILE__ == $0
	puts person
end
