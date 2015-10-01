class Post < ActiveRecord::Base

  attr_accessible :title, :body, :status, :author_id, :created_at
  
  has_many :comments, -> {order 'created_at ASC'}, dependent: :destroy #удалять зависимость, если исчезнет post
                                                  #:destroy - удаление через ActiveRecord, #delete - через SQL, быстрее
           #:foreign_key => 'post_id'
  has_many :categorizations

  has_many :approved_comments, -> { where("comments.status = 'approved'") }, :class_name => 'Comment'
  #  def approved_comments
  #   self.comments.find(:all, :conditions => "status = 'approved'")  
  #  end


  has_many :categories, :through => :categorizations

  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id', :counter_cache => true


end
