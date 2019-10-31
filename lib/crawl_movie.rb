require 'net/http'

apikey = File.read('config/apikey')

result = []
ARGV.each do |id|
	result << Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/movie/#{id}?api_key=#{apikey}&language=en-US"))
end

puts result


