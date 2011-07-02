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

	def remove_email
		@post = Post.new				
	end

	def remove_email_post
		@post = Post.find_by_email(params[:post][:email])		
		
		if @post
			message = "Had a problem deleting your email!"
			message = "Email deleted!" if @post.destroy
		else
			message = "Hmm, don't have that email!"
		end			
		
			
		redirect_to({:controller => :home,:action => :index}, :flash => {:notice => message})

	end

	def remove_email_confirmation
		Mailgun.init(ENV['MAILGUN_KEY']) # setup mailgun using ENV variable for heroku
		
		
		MailgunMessage.send_text(
		sender     = "famulus.fusion@gmail.com",
		recipients = "famulus.fusion@gmail.com",
		subject    = "Hello!",
		text       = "Hi!\nI am sending you a text message using Mailgun",
		servername = "my-mailgun-domain.com")



	end


	private 

	def get_geo_ip(ip)
		IpGeocoder.geocode(ip)		
	end

end
