class UserEditPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @user = user
    @page_url =	edit_user_registration_path user
    @title = "Edit User"

    @profile_picture = ".profile_picture"
    @profile_picture_input = "#user_profile_picture"
    @first_name_input = "#user_first_name"
    @last_name_input = "#user_last_name"
    @current_password_input = "#user_current_password"
    @submit_button = "form.edit_user input[type=submit]"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end

  def has_profile_picture?
    has_css? @profile_picture
  end
  
  def has_profile_picture_input?
    has_css? @profile_picture_input  
  end

  def has_first_name_input?
    has_css? @first_name_input
  end

  def has_last_name_input?
    has_css? @last_name_input
  end

  def submit_form values = {}
    find(@first_name_input).set(values[:first_name]) unless values[:first_name].nil?
    find(@last_name_input).set(values[:last_name]) unless values[:last_name].nil?
    find(@current_password_input).set(values[:current_password]) unless values[:current_password].nil?

    find(@submit_button).click
  end
end
