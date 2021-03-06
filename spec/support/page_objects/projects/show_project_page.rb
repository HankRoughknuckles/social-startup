class ShowProjectPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user, project
    @page_url =	user_project_path user, project
    @title = project.name

    @edit_project_link = ".edit_project"
    @delete_project_link = ".delete_project"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end

  # edit project link
  def has_an_edit_project_link?
    has_css? @edit_project_link
  end

  def click_edit_project_link
    find(@edit_project_link).click
  end

  # edit project link
  def has_a_delete_project_link?
    has_css? @delete_project_link
  end

  def click_delete_project_link
    find(@delete_project_link).click
  end
end
