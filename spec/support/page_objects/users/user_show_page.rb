class UserShowPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize(user)
    @user = user
    @page_url = user_path user
    @title = user.full_name

    @user_projects_link = ".show_projects"
    @edit_profile_link = ".edit_profile"
    @profile_image = ".profile"
  end


  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end


  def has_proper_title?
    has_title? @user.full_name
  end


  def has_users_full_name?
    has_css? "h1.name", text: @user.full_name
  end


  def click_user_projects_link
    page.find(@user_projects_link).click
  end


  def has_an_edit_profile_link?
    has_css? @edit_profile_link
  end

  def has_a_profile_image?
    has_css? @profile_image
  end
end
