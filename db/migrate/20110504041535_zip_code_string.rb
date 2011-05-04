class ZipCodeString < ActiveRecord::Migration
  def self.up
	change_column("posts", "zip_code", :string )
  end

  def self.down
  end
end
