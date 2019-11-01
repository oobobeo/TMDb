class MovieRole < ApplicationRecord
	belongs_to :person
	belongs_to :movie


	def self.initializeDB
		Person.entire_person_ids.each do |id|
			data = Person.crawl_movie_credit(id)
			data['cast'].each do |c|
				params = {'person_id'=>id, 'movie_id'=>c['id'], 'department'=>'Acting','character'=>c['character']}
				mr = MovieRole.new(params)
				if mr.save
					puts mr.inspect
				else
					puts mr.save
				end
			end
			data['crew'].each do |c|
				params = {'person_id'=>id, 'movie_id'=>c['id'], 'department'=>c['department'],'job'=>c['job']}
				mr = MovieRole.new(params)
				if mr.save
					puts mr.inspect
				else
					puts mr.save!
				end
			end
		end
	end



end
