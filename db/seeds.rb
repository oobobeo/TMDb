# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require_relative('../lib/crawl_entire_movie') # entire_movie_ids
require_relative('../lib/crawl_entire_person') # entire_person_ids
require_relative('../lib/crawl_entire_tv') # entire_tv_ids
require_relative('../lib/crawl_movie') # movie(id)
require_relative('../lib/crawl_tv') # tv(id)

# entire_person_ids.each do |id|
# 	tv(id)













