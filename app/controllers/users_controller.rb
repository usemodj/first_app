class UsersController < ApplicationController
  before_filter :authenticate, :only => [ :index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]  
  before_filter :admin_user,  :only => :destroy
    
  def  index
    @title = "All users"
    @users = User.paginate( :page => params[:page])
    end
  
  def new
    @user = User.new
    @title = "Sign up"
  end

  def show
  	@user = User.find(params[:id])
  	@title = @user.name
  end
  
  def create
    @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to  @user
      else
        @title = "Sign up"
        render  :new
      end
  end
  
  def update
    @user = User.find(params[:id])
      #params[:user].delete(:password)
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated."
        redirect_to @user
      else
        flash[:fail] = "Profile doesn't updated."
        @title = "Edit user"
        render :edit
      end
  end
  
  def edit
    #but now that the correct_user before filter defines @user we can omit it from the
    #edit action (and from the update action as well).
    #@user = User.find( params[:id])
    @title = "Edit user"
  end
  
  def destroy
   # User.find(params[:id]).destroy
    user = User.find( params[:id])
    if current_user?( user)
      flash[:notice] = "Admin user doesn't destroy self"
    else
      user.destroy
      flash[:success] = "User destroyed."
    end  
      
   redirect_to users_path
  end
  
  private
  
  def authenticate
    deny_access  unless signed_in?
  end
  
  def correct_user
    @user = User.find( params[:id])
    redirect_to( root_path) unless current_user?( @user) or current_user.admin?
  end
  
  def admin_user
    redirect_to( root_path) unless current_user and current_user.admin?
  end
end
