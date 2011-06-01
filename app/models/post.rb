class Post < ActiveRecord::Base
	acts_as_mappable :default_units => :kms, 
										:default_formula => :sphere, 
										:distance_field_name => :distance,
										:lat_column_name => :lat,
										:lng_column_name => :lng


	
	validates :email, {:presence => { :message => "^Sweet!     If later you want to post? provide an email." }, :uniqueness => true}
	validates :zip_code, :presence => true
	
	scope :buying, where({buying_or_selling: "buy"})
	scope :selling, where({buying_or_selling: "sell"})
	scope :old, where("created_at < ?", (Time.now-7.days))

end
