class EditAboutPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @page_url = edit_about_user_path user
    @title = "Edit 'About Me'"

    @account_host_dropdown = ".external_accounts_hostsite"
    @account_url_input = ".external_accounts_url"

    @submit_button = "form.edit_user input[type=submit]"
  end

  def visit_page
    visit @page_url
  end

  def visit_page_as(user)
    user.present? ? login_as(user) : logout
    visit @page_url
  end

  def has_account_host_dropdown?
    has_css? @account_host_dropdown
  end

  def has_account_url_input?
    has_css? @account_url_input
  end

  def set_hostsite hostsite
    find(@account_host_dropdown).set hostsite unless hostsite.nil?
  end

  def set_url url
    find(@account_url_input).set url unless url.nil?
  end

  def click_submit_button
    find(@submit_button).click
  end

  def submit_external_account account
    set_hostsite account["hostsite"]
    set_url account["url"]

    click_submit_button
  end
end
