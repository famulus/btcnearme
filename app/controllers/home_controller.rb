class HomeController < ApplicationController
	
	def index
		near = Post.find(:all, :origin =>[37.792,-122.393], :within=>10)
		# render(text: near)
		# geocode_ip_address
		
		
		# Post.geo_scope(:origin => [37.792,-122.393])
		
	end
	
end
