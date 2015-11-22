require "spec_helper"

describe "The new projects page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.build(:project, user: user) }
  let(:form) { ProjectForm.new }

  before { visit new_user_project_path(user) }


  describe "The inputs" do
    it { expect(form).to have_a_name_input }
    it { expect(form).to have_a_description_input }
    it { expect(form).not_to have_a_user_input }
  end


  it 'should create a new project when input is valid' do
    form.submit_form name: "something", description: "it's gonna be rad"
    expect(form).to have_success_flash
  end


  it 'should not create a new project when name is missing' do
    form.submit_form name: "", description: "it's gonna be rad"

    expect(form).to have_name_blank_error_flash
  end
end
