class EditUserPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @user = user
    @page_url =	edit_user_registration_path user
    @title = "Edit User"

    @profile_picture = ".profile_picture"
    @profile_picture_input = "#user_profile_picture"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end

  def has_a_profile_picture?
    has_css? @profile_picture
  end
  
  def has_a_profile_picture_input?
    has_css? @profile_picture_input  
  end
end
