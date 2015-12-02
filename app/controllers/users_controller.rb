class UsersController < ApplicationController
  def show
    if user_signed_in?
      @user = User.find params[:id]
      @post = Post.new
    else
      redirect_to new_user_registration_path unless user_signed_in?
    end
  end

  def about
    @user = User.find params[:id]
  end

  def edit_about
    @user = User.find params[:id]
  end
end
