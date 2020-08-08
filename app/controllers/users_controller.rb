class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Handle a succesful save
      flash[:success] = 'Welcome to Litle Talks'
      redirect_to user_path(@user)
    else
      # Errors in the form. Correct them.
      render 'new'
    end

  end
  

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  
end
