class UserProjectsPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize(user)
    @page_url =							    user_projects_path(user)
    @title =								    "#{user.first_name}'s projects"
    @projects_list =            ".projects"

    @user =                     user
    @project_entry_prefix =     ".project_"
    @add_project_link =         ".add_project"
  end


  def visit_page
    visit @page_url
  end


  def has_users_full_name?
    has_css? "h1.name", text: @user.full_name
  end


  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end


  def has_projects_list?
    has_css? @projects_list
  end


  def has_project_name?(project)
    has_css?(project_name_css(project), text: project.name)
  end


  def project_entry(project)
    @project_entry_prefix + project.id.to_s
  end


  def project_name_css(project)
    "tr#{project_entry(project)} .name"
  end


  def has_an_add_project_link?
    has_css? @add_project_link
  end


  def click_add_project_link
    page.find(@add_project_link).click
  end
end
