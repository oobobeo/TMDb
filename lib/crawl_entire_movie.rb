require_relative '../app/models/movie.rb'



if __FILE__ == $0
	output = []
	Movie.entire_movie_ids.each do |id|
		output << Movie.crawl_movie(id)
	end
	puts outputs
end