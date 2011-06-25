class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|

	    t.column :title, :string, :limit => 100, :default => "", :null => false
	    t.column :body, :text, :default => "", :null => false
	    t.column :author, :string, :limit => 100, :default => "", :null => false
	    t.column :category, :string, :limit => 20, :default => "", :null => false
	    t.column :status, :string, :limit => 20, :default => "", :null => false
	    t.column :created_at, :datetime
    end

#	Post.create(:title => "Hello", :body => "Hello from racoon", :author => "Urubok", :category => "Legal", :status => "approved", :created_at => "05.05.1989")

  end

  def self.down
    drop_table :posts
  end
end
