require "spec_helper"

describe "Projects Page" do
  let(:subject_user)    { FactoryGirl.create(:user, first_name: "John",
                                              last_name: "Doe") }
  let(:projects_page)   { UserProjectsPage.new(subject_user) }
  let(:project_1)       { FactoryGirl.create(:project) }
  let(:others_project)  { FactoryGirl.create(:project) }

  before do
    subject_user.projects << project_1
    projects_page.visit_page_as subject_user
  end


  it 'should be accessible from the user show page' do
    user_show_page =  UserShowPage.new(subject_user)

    user_show_page.visit_page_as subject_user
    user_show_page.click_user_projects_link

    expect(page.title).to eq projects_page.title
  end


  context "when logged in as the page's user" do
    before { projects_page.visit_page_as subject_user }

    it { expect(projects_page).to have_projects_list }
    it { expect(projects_page.text).to match /John Doe.+ Projects/ }
    

    describe "the user's projects" do
      it { expect(projects_page).to have_project_name project_1 }
      it { expect(projects_page).not_to have_project_name others_project }
    end


    it "should have a working add project link" do
      projects_page.click_add_project_link
      expect(page).to have_title NewProjectPage.new(subject_user).title
    end
  end
end
