require "spec_helper"

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%% Shared examples
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shared_examples "a user show page" do 
  it { expect(show_page).to have_proper_title }
  it { expect(show_page).to have_users_full_name }
  it { expect(show_page).to have_a_profile_image }
  it { expect(page).to have_content post_1.body }
  it { expect(page).to have_content post_2.body }
end

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%% The specs
##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
describe "User Show Page" do
  let!(:subject_user) { FactoryGirl.create(:user) }
  let!(:post_1) { FactoryGirl.create(:post, body: "post no. 1", user: subject_user) }
  let!(:post_2) { FactoryGirl.create(:post, body: "post no. 2", user: subject_user) }

  # page objects
  let(:show_page) { UserShowPage.new(subject_user) }
  let(:signup_page) { NewRegistrationPage.new }

  it 'should redirect to the signup page when not logged in' do
    show_page.visit_page_as nil 

    expect(page.title).to eq signup_page.title
  end


  context "when logged in as the page's user" do
    before { show_page.visit_page_as subject_user }

    it_should_behave_like "a user show page"

    it { expect(show_page).to have_an_edit_profile_link }

    describe "the new post form" do
      let(:new_post_form) { NewPostForm.new(subject_user) }

      it { expect(new_post_form).to have_a_text_entry }

      it "should create a new post when a body is present" do
        expect{ new_post_form.create_post "This is a post" }
          .to change{ subject_user.posts.count }.by 1
      end

      it "should not create a new post when body is blank" do
        expect{ new_post_form.create_post "" }
          .to change{ subject_user.posts.count }.by 0
      end
    end
  end


  context "when logged in as a different user" do
    let(:other_user) { FactoryGirl.create(:user) }
    before { show_page.visit_page_as other_user }

    it_should_behave_like "a user show page"

    it { expect(show_page).not_to have_an_edit_profile_link }
    it { expect(NewPostForm.new subject_user).not_to have_a_text_entry }
  end
end
