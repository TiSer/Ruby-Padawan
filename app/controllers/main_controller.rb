class MainController < ApplicationController
  
  before_filter :set_all_categories, :set_archive_list

  def index
    @posts = Post.paginate(:page => params[:page], :conditions => "posts.status = 'published'", :order => "posts.created_at DESC", :include => [:author, :categories, :comments], :per_page => 5)
  end

  def category
#    @posts = Post.find(:all, :include => [:author, :categories], :conditions => ["status" = 'published' AND categories.id = ?", params[:id]], :order => "posts.created_at DESC")   почему не работает?!
    @posts = Post.paginate(:page => params[:page], :per_page => 3,
			:include => [:author, :categories],
			:conditions => ["status = 'published' AND categories.id = ?", params[:id]], 
			:order => "posts.created_at DESC")
    render(:action => 'index')
  end

  def archive
    start_time = Time.mktime(params[:year] || 2011, params[:month] || 1, params[:day] || 1)
    end_time = start_time.next_month
    @posts = Post.paginate(:all, :page => params[:page], :per_page => 3,
			:include => [:author, :categories],
			:conditions => ["status = 'published' AND posts.created_at BETWEEN ? AND ?", start_time, end_time], 
			:order => "posts.created_at DESC")
    render(:action => 'index')
  end

  def view_post
    @post = Post.find(params[:id], :include => [:author, :categories, :approved_comments])
    @comment = Comment.new
    render(:template => 'shared/view_post')
  end

  def add_comment
    @comment = Comment.new(params[:comment])
    @post = Post.find(params[:id])
    @comment.post = @post
    @comment.status = "new"
    if @comment.save
      flash[:notice] = "your comment was submitted successfully, it will be posted after admin's approval"
      redirect_to(post_view_path, :id => @post.id)
    else
      render(:template => 'shared/view_post')
    end
  end

  private #-----------------------------------------------------------------------------------------------

  def set_all_categories
    @all_categories = Category.find(:all, :order => "name ASC")
  end

  def set_archive_list
    posts = Post.find(:all, :conditions => ["status = 'published'"], :order => "created_at DESC")
    @archive_list = posts.collect do |p|
      [p.created_at.strftime("%b %Y"), p.created_at.year, p.created_at.month]
    end
    @archive_list.uniq!
  end

end
