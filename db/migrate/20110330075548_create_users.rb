class CreateUsers < ActiveRecord::Migration
   def self.up
    create_table :users do |t|

	t.column :username,       :string, :limit => 50, :default => "", :null => false
	t.column :hashed_password,:string, :limit => 40, :default => "", :null => false
	t.column :first_name,     :string, :limit => 50, :default => "", :null => false
	t.column :last_name,      :string, :limit => 50, :default => "", :null => false
	t.column :email,          :string, :limit => 50, :default => "", :null => false
	t.column :display_name,   :string, :limit => 50, :default => "", :null => false
	t.column :user_level,    :integer, :limit => 5,  :default => 0,  :null => false
	
    end

#	User.create(:username => "racoon", :hashed_password => "racoon", :first_name => "Urubok", :last_name => "Ury", :email => "uruby@mailforspam.com", :display_name => 'Racoony', :user_level => 9)

  end

  def self.down
    drop_table :users
  end
end
