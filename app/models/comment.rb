class Comment < ActiveRecord::Base
  
  validates_presence_of :author, :author_email, :content, :status
  validates_length_of   :author, :within => 3..25
  validates_inclusion_of:status, :in => %w{new approved spam}
  validates_format_of   :author_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  belongs_to :post, :counter_cache => true#, :class_name => 'Post', :foreign_key => 'post_id'

  def before_validation
    self.author.strip!
    self.author_email.strip!
  end

  private #----------------------------------------------------------------------------------

  def validate
    errors.add(:author, "you can't take this name, sorry") if self.author == "TiSer"
    errors.add_to_base("TiSer can't be the author, sorry") if self.author == "TiSer"
  end

end
