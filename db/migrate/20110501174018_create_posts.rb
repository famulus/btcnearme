class CreatePosts < ActiveRecord::Migration
	def self.up
		create_table :posts do |t|
			t.string  :buying_or_selling
			t.string  :email
			t.decimal  :lat
			t.decimal  :lng
			t.decimal  :quantity
			t.string :zip_code
			
			t.timestamps
		end
		add_index(:posts,:lat)
		add_index(:posts,:lng)
	end

	def self.down
		drop_table :posts
	end
end
