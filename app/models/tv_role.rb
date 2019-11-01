class TvRole < ApplicationRecord
	belongs_to :person
	belongs_to :tv
end
