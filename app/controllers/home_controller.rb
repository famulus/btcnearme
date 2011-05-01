class HomeController < ApplicationController
	
	def index
		# near = Location.find(:all, :origin =>[37.792,-122.393], :within=>10)
		# render(text: near)
		# geocode_ip_address
		
		Post.within(5, :origin =>[37.792,-122.393])
		# Pos.geo_scope(:origin => [37.792,-122.393])
		
	end
	
end
