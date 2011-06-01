class HomeController < ApplicationController

	def index
		@post = Post.new

		if cookies[:zip_code].present?

				begin
					@ip_location = get_geo_ip(request.remote_ip)
					origin_string = "#{cookies[:zip_code]}, #{@ip_location.country_code if @ip_location.success}"
					@posts = Post.within(500, :origin => origin_string).order('distance asc') 
				rescue 
					@posts = Post.all
					flash[:error]= "Whoops! We had a problem locating you! Maybe try again?"
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
