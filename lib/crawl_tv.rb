require_relative '../app/models/tv.rb'


if __FILE__ == $0
	result = []
	ARGV.each do |id|
		result << Tv.crawl_tv(id)
	end
	puts result
end