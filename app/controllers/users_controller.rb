class UsersController < ApplicationController
  def show
    if user_signed_in?
      @user = User.find params[:id]
    else
      redirect_to new_user_registration_path unless user_signed_in?
    end
  end
end
