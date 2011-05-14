class HomeController < ApplicationController

	def index
		@post = Post.new
		if cookies[:zip_code].present?
			if Rails.env == "production"
				location = get_geo_ip
				@posts = Post.within(60, :origin =>"#{cookies[:zip_code]}, #{location.country_code if location.success}",:order=>'distance') 
				@posts.sort_by_distance_from(cookies[:zip_code])
			else
				@posts = Post.all #Google's API doesn't work locally yet
			end
			@buying = @posts.select{|p| p.buying_or_selling == "buy"}
			@selling = @posts.select{|p| p.buying_or_selling == "sell"}
		end
	end



	def create_post
		@post = Post.new
		@post.update_attributes(params[:post])
		@post.lat = MultiGeocoder.geocode("#{@post.zip_code.to_s}, #{get_geo_ip.country_code if get_geo_ip.success}").lat rescue nil
		@post.lng = MultiGeocoder.geocode("#{@post.zip_code.to_s}, #{get_geo_ip.country_code if get_geo_ip.success}").lng rescue nil	
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

	def get_geo_ip
		IpGeocoder.geocode(request.remote_ip)		
	end

end
