require_relative '../app/models/tv.rb'



if __FILE__ == $0
	output = []
	Tv.entire_tv_ids.each do |id|
		output << Tv.crawl_tv(id)
	end
	puts output
end