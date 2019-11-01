require_relative '../app/models/person.rb'
require_relative '../app/models/tv.rb'
require_relative '../app/models/movie.rb'
require_relative '../app/models/movie_role.rb'
require_relative '../app/models/tv_role.rb'

Person.updateDB
Movie.updateDB
Tv.updateDB
TvRole.updateDB
MovieRole.updateDB