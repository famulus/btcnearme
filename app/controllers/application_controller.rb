include Geokit
include Geokit::Geocoders
include Geokit::IpGeocodeLookup

class ApplicationController < ActionController::Base
  protect_from_forgery
	helper :all
  protect_from_forgery
  geocode_ip_address
  
  before_filter :geokit

  def geokit 
    store_ip_location
    @current_location = session[:geo_location]  # @current_location is a GeoLoc instance. 
  end
  def store_location
    session[:return_to] = request.request_uri
  end
  
end