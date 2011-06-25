class AlterPosts < ActiveRecord::Migration
  def self.up
#	add_column :posts, :updated_at, :datetime
	change_column :posts, :author, :string, :default => 0, :null => false
	rename_column :posts, :author, :author_id
	add_index :posts, :author_id
  end

  def self.down
#	remove_column :posts, :updated_at
	remove_index :posts, :author_id
	rename_column :posts, :author_id, :author
	change_column :posts, :author, :string, :default => 0, :null => false

	#raise ActiveRecord::IrreversibleMigration
	# (if converting ingeres back to string should not be allowed)
  end
end
