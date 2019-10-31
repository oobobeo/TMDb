require_relative '../app/models/movie.rb'


if __FILE__ == $0
	result = []
	ARGV.each do |id|
		result << Movie.crawl_movie(id)
	end
	puts result
end

