class UserAboutPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @user = user
    @page_url =	about_user_path user
    @title = "About #{user.first_name}"

    @hostsite_entry = ".host"
    @exteral_account_url_entry = ".external_url"

    @edit_about_link = ".edit_about"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end

  def has_an_edit_about_link?
    has_css? @edit_about_link
  end

  def has_hostsite? hostsite
    has_css? @hostsite_entry, text: hostsite
  end

  def has_external_account_url? url
    has_css? @exteral_account_url_entry, text: url
  end

  def click_edit_about_link
    find(@edit_about_link).click
  end
end
