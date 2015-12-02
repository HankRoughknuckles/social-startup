class UserAboutPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @user = user
    @page_url =	about_user_path user
    @title = "About #{user.first_name}"

    @edit_link = ".edit"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end

  def has_an_edit_link?
    has_css? @edit_link
  end
end
