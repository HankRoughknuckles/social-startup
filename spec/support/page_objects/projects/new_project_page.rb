class NewProjectPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @user = user
    @page_url = new_user_project_path(user)
    @title = "Create Project"

    @user_input = "input#project_user_id"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end


  def has_user_input?
    has_css? @user_input
  end
end
