class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|

	t.column :content, 	:text, 		       :default => "", :null => false
	t.column :author, 	:string, :limit => 50, :default => "", :null => false
	t.column :author_email, :string, :limit => 50, :default => "", :null => false
	t.column :status, 	:string, :limit => 50, :default => "", :null => false
	t.column :created_at, 	:datetime
	t.column :post_id, 	:integer,	       :default => 0,  :null => false
    end
  end

  def self.down
    drop_table :comments
  end
end
