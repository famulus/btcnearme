class AddNoteToPost < ActiveRecord::Migration
  def self.up
		add_column :posts, :note, :string
  end

  def self.down
  end
end
