require "spec_helper"

describe "The Project Show Page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, user: user) }
  let(:show_page) { ShowProjectPage.new user, project }

  context 'when logged in as the owner' do
    before { show_page.visit_page_as user }

    it 'should have a working edit project link' do
      edit_page = EditProjectPage.new user, project

      show_page.click_edit_project_link

      expect(page).to have_title edit_page.title
    end


    it "should have a working delete project link" do
      expect{ show_page.click_delete_project_link }
        .to change {Project.count}.by -1
    end
  end


  context 'when logged in as someone other than the owner' do
    let(:non_owner) { FactoryGirl.create(:user) }

    before { show_page.visit_page_as non_owner }

    it { expect(show_page).not_to have_an_edit_project_link }
    it { expect(show_page).not_to have_a_delete_project_link }
  end
end
