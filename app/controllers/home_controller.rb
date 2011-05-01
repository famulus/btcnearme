class HomeController < ApplicationController
	
	def index
		# near = Location.find(:all, :origin =>[37.792,-122.393], :within=>10)
		# render(text: near)
		# geocode_ip_address
		
		# Post.within(5, :origin =>[37.792,-122.393])
# @location = IpGeocoder.geocode(request.remote_ip)


		@post = Post.new
		@posts = Post.all
	end
	
	def create_post
				@post = Post.new

		@post.update_attributes(params[:post])
		@post.save
		redirect_to({:controller => :home,:action => :index})
		
	end
	
end
