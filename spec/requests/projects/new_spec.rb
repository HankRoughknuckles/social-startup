require "spec_helper"

describe "The new projects page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let(:new_page) { NewProjectPage.new(project) }

  before { new_page.visit_page_as user }

  it { expect(new_page).not_to have_user_input }
end
