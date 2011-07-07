class AddCountryToPost < ActiveRecord::Migration
  def self.up
		add_column :posts, :country, :string
  	end

  def self.down
  end
end
