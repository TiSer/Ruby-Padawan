class CommentsController < ApplicationController
  
  layout "staff"

  before_filter :authorize_access

  def index
    case params[:status]
    when 'approved'
      @comments = Comment.find(:all, :conditions => "status = 'approved'", :order => 'created_at DESC')
    when 'spam'
      @comments = Comment.find(:all, :conditions => "status = 'spam'", :order => 'created_at DESC')      
    when 'all'
      @comments = Comment.find(:all, :order => 'created_at DESC')
    else #new
      @comments = Comment.find(:all, :conditions => "status = 'new'", :order => 'created_at DESC')      
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def set_status
    begin
      status = params[:commit] || ""
      checked_items = params[:commentlist]
      checked_items.each do |id|
        Comment.update(id.to_i, :status => status.downcase)
      end
      flash[:notice] = "checked items have been succesfully updated"
      redirect_to(:action => 'index')
    rescue 
    flash[:notice] = "unknown error occurred"
    redirect_to(:action => 'index')
    end
  end

end
