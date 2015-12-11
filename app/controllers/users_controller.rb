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
    @user.external_accounts.build
  end

  def update_about
    @user = User.find params[:id]

    if @user.update(about_params)
      redirect_to [@user, @project], notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  private
    def about_params
      params.require(:user).permit(
        external_accounts_attributes: [:id, :hostsite, :url]
      )
    end
end
