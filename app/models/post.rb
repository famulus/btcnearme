class Post < ActiveRecord::Base
	acts_as_mappable :default_units => :kms, 
										:default_formula => :sphere, 
										:distance_field_name => :distance,
										:lat_column_name => :lat,
										:lng_column_name => :lng


	validates_presence_of :zip_code
	validates_presence_of :email, :message => "required to post"
	validates_uniqueness_of :email, :scope => :buying_or_selling
end
