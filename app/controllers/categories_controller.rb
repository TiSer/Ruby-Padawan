class CategoriesController < ApplicationController

  layout "staff"
  
  before_filter :authorize_access

  def index
    @categories = Category.all

    @category = Category.find(params[:id]) if params[:id]
    @category = Category.new if @category.nil?

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categories }
    end
  end

  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to(categories_path, :notice => 'Category was successfully created.') }
        format.xml  { render :xml => @categories, :status => :created, :location => @category }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to(categories_url, :notice => 'Category was successfully updated.') }
        format.xml  { render :xml => @categories, :status => :created, :location => @category }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
#      format.html { render :action => "index" }
      format.html { redirect_to(categories_url) }
      format.xml  { head :ok }
    end
  end
end
