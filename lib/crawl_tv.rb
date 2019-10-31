require 'net/http'

apikey = File.read('config/apikey')

def tv(id)
	Net::HTTP.get(URI.parse("https://api.themoviedb.org/3/tv/#{id}?api_key=#{apikey}&language=en-US"))
end

if __FILE__ == $0
	result = []
	ARGV.each do |id|
		result << tv(id)
	end
	puts result
end