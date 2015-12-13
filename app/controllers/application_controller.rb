class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:account_update) << [
        :profile_picture, :first_name, :last_name,
        external_accounts_attributes: [:hostsite, :url]
      ]
    end

  private
    def set_user id
      @user = User.find id
    end


    def correct_user user_to_check
      if current_user.nil? 
        redirect_to new_user_registration_path, alert: "Please log in first."
      elsif user_to_check != current_user
        redirect_to root_path, alert: "Sorry, that's unauthorized."
      end
    end
end

