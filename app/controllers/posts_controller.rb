class PostsController < ApplicationController

  layout "staff"

  before_filter :prepare, :only => [:create, :update]
  before_filter :authorize_access

  def index
    #paginate is going to access params[:page]
#    @post_pages, @posts = paginate(:posts, :per_page => 3)

#     @posts = Post.paginate(:page => params[:page], :conditions => "status = 'published'", :order => "posts.created_at DESC", :include => [:author, :categories, :comments])

    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    @all_categories = Category.find(:all, :order => "name ASC")
    #render (:template => 'shared/view_post', :layout => 'application')
    respond_to do |format|
     format.html { redirect_to(post_view_path,  :layout => 'application')}
     # format.html # show.html.erb
     # format.xml  { render :xml => @post }
    end
  end
  alias :view_post :show

  def new
    @post = Post.new
    @user_list = get_user_list
    @all_categories = get_all_categories

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
    @user_list = get_user_list
    @all_categories = get_all_categories
  end

  def create
    #@post = Post.new(params[:post])
    #author_id = params[:post].delete(:author_id)
    #@post.author = User.find(params[:post][:author_id])
    
    @post = Post.new(@post_params)
    @post.author = User.find(@author_id) #тащим id автора только 1 раз и только если он есть в БД

    respond_to do |format|
      if @post.save
        @checked_categories.each { |cat| @post.categories << cat      if !@post.categories.include?(cat) }
        @removed_categories.each { |cat| @post.categories.delete(cat) if  @post.categories.include?(cat) }
        format.html { redirect_to(posts_path, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        @user_list = get_user_list
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    
    @post = Post.find(params[:id])
    @post.author = User.find(@author_id) if @post.author_id != @author_id

    respond_to do |format|
      if @post.update_attributes(params[:post])
        @checked_categories.each { |cat| @post.categories << cat      if !@post.categories.include?(cat) }
        @removed_categories.each { |cat| @post.categories.delete(cat) if  @post.categories.include?(cat) }
        format.html { redirect_to(posts_path, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        @user_list = get_user_list
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end


  private #------------------------------------------------------------------------------------------

  def prepare
    @post_params = params[:post]
    @author_id = @post_params.delete(:author_id)
      @all_categories = get_all_categories
      @checked_categories = get_categories_from(params[:categories])
      @removed_categories = @all_categories - @checked_categories
  end

  def get_user_list
    return User.find(:all, :order => 'last_name ASC').collect { |user| [ user.full_name, user.id ] }
  end

  def get_all_categories
    return Category.find(:all, :order => 'name ASC')
  end

  def get_categories_from(cat_list)
    cat_list = [] if cat_list.blank?
    return cat_list.collect { |cid| Category.find_by_id(cid.to_i) }.compact  #compact убивает все nil
  end

end
