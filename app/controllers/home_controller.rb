class HomeController < ApplicationController

	def index
		@post = Post.new
		if cookies[:zip_code].present?
			@posts = Post.within(20, :origin =>cookies[:zip_code],:order=>'distance')
			@posts.sort_by_distance_from(cookies[:zip_code])
			# @posts = Post.all
		end
	end



	def create_post
		@post = Post.new

		@post.update_attributes(params[:post])
		@post.lat = MultiGeocoder.geocode(@post.zip_code.to_s).lat rescue nil
		@post.lng = MultiGeocoder.geocode(@post.zip_code.to_s).lng rescue nil	

		if @post.save
		cookies[:zip_code] = @post.zip_code if @post.zip_code.present?
		redirect_to({:controller => :home,:action => :index})

	end




end
