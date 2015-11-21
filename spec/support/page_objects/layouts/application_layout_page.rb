class ApplicationLayoutPage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def initialize
    @profile_button = ".header .profile"
    @sign_out_button = ".header .sign_out"
    @sign_in_button = ".header .sign_in"
  end

  def click_profile_button
    find(@profile_button).click
  end

  #sign in button
  def has_sign_in_button?
    has_css? @sign_in_button
  end

  def click_sign_in_button
    find(@sign_in_button).click
  end


  #sign out button
  def click_sign_out_button
    find(@sign_out_button).click
  end
end
