class TvRole < ApplicationRecord
	belongs_to :person
	belongs_to :tv



	def self.initializeDB
		Person.entire_person_ids.each do |id|
			data = Person.crawl_tv_credit(id)
			data['cast'].each do |c|
				params = {'person_id'=>id, 'tv_id'=>c['id'], 'department'=>'Acting','character'=>c['character']}
				tr = TvRole.new(params)
				tr.save
				puts tr.inspect
				break
			end
			data['crew'].each do |c|
				params = {'person_id'=>id, 'tv_id'=>c['id'], 'department'=>c['department'],'job'=>c['job']}
				tr = TvRole.new(params)
				tr.save
				puts tr.inspect
				break
			end
		end
	end

end
