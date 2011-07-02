class AddTokenToPost < ActiveRecord::Migration
  def self.up
		add_column :posts, :token, :string
		add_column :posts, :token_timestamp, :datetime
  end

  def self.down
  end
end
