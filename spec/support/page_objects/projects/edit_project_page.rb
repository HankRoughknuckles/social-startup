class EditProjectPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user, project
    @page_url =	edit_user_project_path user, project
    @title = "Edit Project - #{project.name}"

    @user = user
    @project = project
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end
end
