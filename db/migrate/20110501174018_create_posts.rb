class CreatePosts < ActiveRecord::Migration
	def self.up
		create_table :posts do |t|
			t.string  :buying_or_selling
			t.string  :email
			t.decimal  :lat
			t.decimal  :lng
			t.decimal  :quantity
			t.integer :zip_code
			
			t.timestamps
		end
	end

	def self.down
		drop_table :posts
	end
end
