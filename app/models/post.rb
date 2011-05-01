class Post < ActiveRecord::Base
	acts_as_mappable
	validates_numericality_of :zip_code
end
