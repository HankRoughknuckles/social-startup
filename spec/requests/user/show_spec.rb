require "spec_helper"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%% Shared examples
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shared_examples "a user show page" do 
  it { expect(show_page).to have_proper_title }
  it { expect(show_page).to have_users_full_name }
  it { expect(show_page).to have_a_profile_image }
end

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%% The specs
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
describe "User Show Page" do
  let(:subject_user) { FactoryGirl.create(:user) }

  # page objects
  let(:show_page) { UserShowPage.new(subject_user) }
  let(:signup_page) { SignupPage.new }


  it 'should redirect to the signup page when not logged in' do
    show_page.visit_page_as nil 

    expect(page.title).to eq signup_page.title
  end


  context "when logged in as the page's user" do
    before { show_page.visit_page_as subject_user }

    it_should_behave_like "a user show page"

    it { expect(show_page).to have_an_edit_profile_link }
  end


  context "when logged in as a different user" do
    let(:other_user) { FactoryGirl.create(:user) }
    before { show_page.visit_page_as other_user }

    it_should_behave_like "a user show page"

    it { expect(show_page).not_to have_an_edit_profile_link }
  end
end

