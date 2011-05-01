class HomeController < ApplicationController

	def index
		# near = Location.find(:all, :origin =>[37.792,-122.393], :within=>10)
		# render(text: near)
		# geocode_ip_address

		# Post.within(5, :origin =>[37.792,-122.393])
		# @location = IpGeocoder.geocode(request.remote_ip)


		@post = Post.new
		if cookies[:zip_code].present?
			@posts = Post.within(5, :origin =>cookies[:zip_code],:order=>'distance')
		end
	end

	def create_post
		@post = Post.new

		@post.update_attributes(params[:post])
		@post.lat = MultiGeocoder.geocode(@post.zip_code.to_s).lat rescue nil
		@post.lng = MultiGeocoder.geocode(@post.zip_code.to_s).lng rescue nil	

		@post.save
		cookies[:zip_code] = @post.zip_code
		redirect_to({:controller => :home,:action => :index})

	end

end
