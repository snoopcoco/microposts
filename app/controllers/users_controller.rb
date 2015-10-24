class UsersController < ApplicationController
  
  def followings
    @title = "Followings"
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @followings = @user.follower_users
    render 'followings'
  end
  
  def show 
   @user = User.find(params[:id])
   @microposts = @user.microposts
   
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
