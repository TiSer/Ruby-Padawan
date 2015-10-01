class MainController < ApplicationController
  
  before_filter :set_all_categories, :set_archive_list

  def index
    @posts = Post.includes(:author, :categories, :comments).where("posts.status = 'published'").paginate(:page => params[:page], :per_page => 10).order("posts.created_at DESC")
  end

  def category
#    @posts = Post.find(:all, :include => [:author, :categories], :conditions => ["status" = 'published' AND categories.id = ?", params[:id]], :order => "posts.created_at DESC")   почему не работает?!
    @posts = Post.order("posts.created_at DESC")
      .includes(:author, :categories)
      .where("status = 'published' AND categories.id = ?", params[:id])
      .paginate(:page => params[:page], :per_page => 10)
      .references(:categoies)
    render(:action => 'index')
  end

  def archive
    start_time = Time.mktime(params[:year] || 2011, params[:month] || 1, params[:day] || 1)
    end_time = start_time.next_month
    @posts = Post.order("posts.created_at DESC")
      .paginate(:page => params[:page], :per_page => 10)
      .includes(:author, :categories)
      .where("status = 'published' AND posts.created_at BETWEEN ? AND ?", start_time, end_time)

    render(:action => 'index')
  end

  def view_post
    @post = Post.includes(:author, :categories, :approved_comments).find(params[:id])
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

  private

  def set_all_categories
    @all_categories = Category.all.order("name ASC")
  end

  def set_archive_list
    posts = Post.all.where("status = 'published'").order("created_at DESC")
    @archive_list = posts.collect do |p|
      [p.created_at.strftime("%b %Y"), p.created_at.year, p.created_at.month]
    end
    @archive_list.uniq!
  end

end
