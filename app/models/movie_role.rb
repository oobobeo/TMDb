class MovieRole < ApplicationRecord
	belongs_to :person
	belongs_to :movie


	def self.initializeDB
		Person.entire_person_ids.each do |id|
			data = Person.crawl_movie_credit(id)

			counter = 0
			data['cast'].each do |c|
				params = {'person_id'=>id, 'movie_id'=>c['id'], 'department'=>'Acting','character'=>c['character']}
				mr = MovieRole.new(params)
				mr.save
				if counter % 100 == 0
					puts mr.inspect
				end
			end

			counter = 0
			data['crew'].each do |c|
				params = {'person_id'=>id, 'movie_id'=>c['id'], 'department'=>c['department'],'job'=>c['job']}
				mr = MovieRole.new(params)
				mr.save
				if counter % 100 == 0
					puts mr.inspect
				end
			end
		end
	end


	def self.updateDB
		ids = Person.changed_ids
		ids.each do |id|
			data = Person.crawl_movie_credit(id)

			counter = 0
			data['cast'].each do |c|
				params = {'person_id'=>id, 'movie_id'=>c['id'], 'department'=>'Acting','character'=>c['character']}
				mr = MovieRole.find_by_person_id(id)
				mr.update(params)
				mr.save
				if counter % 100 == 0
					puts mr.inspect
				end
			end

			counter = 0
			data['crew'].each do |c|
				params = {'person_id'=>id, 'movie_id'=>c['id'], 'department'=>c['department'],'job'=>c['job']}
				mr = MovieRole.find_by_person_id(id)
				mr.update(params)
				mr.save
				if counter % 100 == 0
					puts mr.inspect
				end
			end

		end
	end

end
