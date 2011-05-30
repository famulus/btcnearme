class HomeController < ApplicationController

	def index
		@post = Post.new

		if cookies[:zip_code].present?
			if Rails.env == "production"
	
				begin
					@ip_location = get_geo_ip(request.remote_ip)
					origin_string = "#{cookies[:zip_code]}, #{@ip_location.country_code if @ip_location.success}"
				rescue 
					@posts = []
					flash[:error]= "Whoops! We had a problem locating you by IP! Maybe try again?"
				end
				
				begin
					@posts = Post.within(300, :order=>'distance asc', :origin => origin_string) 
				rescue 
					@posts = []
					flash[:error]= "Whoops! We had a problem locating you! Maybe try again? (error finding within distance)"
				end

				# begin
				# 	@posts.sort_by_distance_from(origin_string) # order not supported in Rails 3 geokit
				# rescue 
				# 	@posts = []
				# 	flash[:error]= "Whoops! We had a problem locating you! Maybe try again? (error sorting by distance)"
				# end


			else
				@posts = Post.all #Google's API doesn't work locally yet
			end
			@buying = @posts.select{|p| p.buying_or_selling == "buy"}
			@selling = @posts.select{|p| p.buying_or_selling == "sell"}
		end
	end



	def create_post
		@ip_location = get_geo_ip(request.remote_ip)
		@post = Post.new
		@post.update_attributes(params[:post])
		geo_results = MultiGeocoder.geocode("#{@post.zip_code}, #{@ip_location.country_code if @ip_location.success}")
		@post.lat = geo_results.lat 
		@post.lng = geo_results.lng 
		@post.save
		cookies[:zip_code] = @post.zip_code if @post.zip_code.present?
		cookies[:email] = @post.email if @post.valid?
		if @post.valid?
			redirect_to({:controller => :home,:action => :index}, :flash => {:notice => "Post success!"})
		else
			redirect_to({:controller => :home,:action => :index}, :flash => {:error => @post.errors.full_messages.join(", ")})
		end
	end




	def delete_post
		if cookies[:email] == params[:email]
			p =Post.find_by_email(params[:email])
			p.destroy
		end
		redirect_to({:controller => :home,:action => :index}, :flash => {:notice => "Email deleted sucessfully"})
	end 




	private 

	def get_geo_ip(ip)
		IpGeocoder.geocode(ip)		
	end

end
