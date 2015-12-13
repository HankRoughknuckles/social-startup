class UsersController < ApplicationController
  before_action { set_user params[:id] }
  before_action only: [:update_about] { correct_user(@user) }

  def show
    if user_signed_in?
      @post = Post.new
    else
      redirect_to new_user_registration_path unless user_signed_in?
    end
  end


  def about
  end


  def edit_about
    3.times { @user.external_accounts.build }
  end


  def update_about
    if @user.update(about_params)
      redirect_to about_user_path(@user), 
        notice: 'Project was successfully updated.'
    else
      render :edit_about
    end
  end


  private
    def about_params
      params.require(:user).permit(
        external_accounts_attributes: [:id, :hostsite, :url, :_destroy]
      )
    end
end
