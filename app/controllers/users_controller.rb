class UsersController < ApplicationController
  def show
    if user_signed_in?
      @user = User.find params[:id]
    else
      redirect_to new_user_registration_path unless user_signed_in?
    end
  end


  def update
    @user.assign_attributes user_params

    respond_to do |format|
      if @user.save
        format.html { redirect_to ideas_path, notice: 'Your profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def user_params
    params.require(:user).allow(:profile_picture)
  end
end
