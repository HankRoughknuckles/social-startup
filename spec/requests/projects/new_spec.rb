require "spec_helper"

describe "The new projects page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let(:new_page) { NewProjectPage.new(project) }
end
