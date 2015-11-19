class ProjectForm
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  attr_reader :title

  def initialize
    @title = "Create Project"

    @name_input = "#project_name"
    @description_input = "#project_description"
    @user_input = "#project_user_id"
    @submit_button = "form.new_project input[type=submit]"

    @alert_flash = ".alert"
    @error_explanation = "#error_explanation"
  end


  # inputs
  def has_a_name_input?
    has_css? @name_input
  end

  def has_a_description_input?
    has_css? @description_input
  end

  def has_a_user_input?
    has_css? @user_input
  end

  def fill_inputs_with inputs = {}
    find(@name_input).set inputs[:name] unless inputs[:name].nil?
    find(@description_input).set(inputs[:description]) unless inputs[:description].nil?
  end

  def submit_form inputs = {}
    fill_inputs_with inputs
    click_submit
  end

  def click_submit
    find(@submit_button).click
  end


  #flash messages
  def has_success_flash?
    has_css? @alert_flash, text: "successful"
  end

  def has_name_blank_error_flash?
    has_css? @error_explanation, text: "Name can't be blank"
  end
end
