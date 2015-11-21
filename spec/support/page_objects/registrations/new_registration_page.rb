class NewRegistrationPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize
    @page_url =	new_user_registration_path
    @title = "Create an Account"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end
end
