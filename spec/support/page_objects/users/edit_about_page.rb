class EditAboutPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @page_url = edit_about_user_path user
    @title = "Edit 'About Me'"

    @account_host_dropdown = ".external_accounts_hostsite"
    @account_url_input = ".external_accounts_url"
    @interests_input = "#user_interest_list"

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

  def has_interests_input?
    has_css? @interests_input
  end

  def set_hostsite hostsite
    dropdowns = page.all @account_host_dropdown
    dropdowns[0].set hostsite unless hostsite.nil?
  end

  def set_url url
    inputs = page.all @account_url_input
    inputs[0].set url unless url.nil?
  end

  def fill_interests input_string
    find(@interests_input).set input_string 
  end

  def click_submit_button
    find(@submit_button).click
  end

  def submit_external_account account
    set_hostsite account[:hostsite]
    set_url account[:url]

    click_submit_button
  end
end
