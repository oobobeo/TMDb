require_relative '../app/models/person.rb'

if __FILE__ == $0
	output = []
	Person.entire_person_ids.each do |id|
		output << Person.crawl_person(id)
	end
	puts output
end
