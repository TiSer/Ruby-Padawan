class MakeUser < ActiveRecord::Migration
  def self.up
    User.create(:username => "racoon", :hashed_password => "racoon", :first_name => "Urubok", :last_name => "Ury", :email => "uruby@mailforspam.com", :display_name => 'Racoony', :user_level => 9)
  end

  def self.down
    User.delete(:username => "racoon", :hashed_password => "racoon", :first_name => "Urubok", :last_name => "Ury", :email => "uruby@mailforspam.com", :display_name => 'Racoony', :user_level => 9)
  end
end
