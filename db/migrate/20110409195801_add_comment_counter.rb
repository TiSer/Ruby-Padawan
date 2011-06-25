class AddCommentCounter < ActiveRecord::Migration
  def self.up
    add_column :posts, :comments_count, :integer, :limit => 4, :default => 0, :null => false    
     Post.reset_column_information
      Post.find_each do |post|
      Post.reset_counters post.id, :comments
      end
  end

  def self.down
    remove_column :posts, :comments_count
  end
end
