class NewPostForm
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize user
    @user = user
    @text_entry = "#post_body"
    @submit_button = "form.new_post input[type=submit]"
  end

  def has_a_text_entry?
    has_css? @text_entry
  end

  def create_post body
    fill_post_body body
    click_submit_button
  end

  def fill_post_body body
    find(@text_entry).set body
  end

  def click_submit_button
    find(@submit_button).click
  end
end
