class UsersController < ApplicationController

  before_filter :authorize_access

  def index
    @users = User.all
  end

  def manage
    index
    if request.get? && params[:id].blank?      #new
      @user = User.new
    elsif request.post? && params[:id].blank?  #create
      @user = User.new(params[:user])
      if @user.save
      respond_to do |format|
         format.html { redirect_to(users_url, :notice => 'Category was successfully created.') }
         format.xml  { render :xml => @users, :status => :created, :location => @user }
      end
      else
         format.html { render :action => "index" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end   
    elsif request.get? && !params[:id].blank?  #edit 
      @user = User.find(params[:id])
    elsif request.put? && !params[:id].blank? #update or delete
      if params[:commit] == 'Edit'
       @user = User.find(params[:id])
       if @user.update_attributes(params[:user])
       respond_to do |format|
         format.html { redirect_to(users_url, :notice => 'Category was successfully updated.') }
         format.xml  { render :xml => @users, :status => :created, :location => @user }
       end
       else
         format.html { render :action => "index" }
         format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
       end
      end
    elsif request.delete? && !params[:id].blank? #else # action will delete
      User.find(params[:id]).destroy
      flash[:notice] = 'User was successfully delete.'
      redirect_to :action => 'index' 
    end
  end


end
