class AddPostCounter < ActiveRecord::Migration
  def self.up
    add_column :users, :posts_count, :integer, :limit => 4, :default => 0, :null => false
     User.reset_column_information
      User.find_each do |user|
      User.reset_counters user.id, :posts
      end
    add_column :categories, :posts_count, :integer, :limit => 4, :default => 0, :null => false
      #Category.reset_column_information
      #Category.find(:all).each do |category|
       # Category.update_counters category.id, :posts_count => category.posts.length
      #end

     #Category.reset_column_information
     # Category.find_each do |category|
     # Category.reset_counters category.id, :posts
     # end
  end

  def self.down
    remove_column :users, :posts_count
    remove_column :categories, :posts_count
  end
end
