class ZipCodeString2 < ActiveRecord::Migration
  def self.up
		change_column(:posts, :zip_code, :text	 )
  end

  def self.down
  end
end
