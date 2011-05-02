class HomeController < ApplicationController

	def index
		@post = Post.new
		if cookies[:zip_code].present?
			if Rails.env == "production"
				@posts = Post.within(20, :origin =>"#{cookies[:zip_code]}, #{IpGeocoder.geocode(request.remote_ip).country_code}",:order=>'distance')
				@posts.sort_by_distance_from(cookies[:zip_code])
			end
			 @posts = Post.all if Rails.env == "development"
		end
	end



	def create_post
		@post = Post.new

		@post.update_attributes(params[:post])
		@post.lat = MultiGeocoder.geocode("#{@post.zip_code.to_s}, #{IpGeocoder.geocode(request.remote_ip).country_code}").lat rescue nil
		@post.lng = MultiGeocoder.geocode("#{@post.zip_code.to_s}, #{IpGeocoder.geocode(request.remote_ip).country_code}").lng rescue nil	

		@post.save
		cookies[:zip_code] = @post.zip_code if @post.zip_code.present?
		redirect_to({:controller => :home,:action => :index}, :flash => {:error => @post.errors.full_messages.join(", ")})

	end




end
