require "spec_helper"

describe "About User Page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:github_account) { FactoryGirl.create(:external_account, user: user,
                                             hostsite: "github", 
                                             url: "www.github.com/asdf") }
  let!(:linkedin_account) { FactoryGirl.create(:external_account, user: user,
                                               hostsite: "linkedin", 
                                               url: "linkedin.com/asdf") }
  let(:about_page) { UserAboutPage.new user }

  it "should be accessible from the user show page" do
    user_show_page = UserShowPage.new user

    user_show_page.visit_page_as user
    user_show_page.click_about_page_link

    expect(page.title).to eq about_page.title
  end

  describe "external accounts" do
    it "should not have a link to edit when visiting as non-owner" do
      other_user = FactoryGirl.create(:user)

      about_page.visit_page_as other_user

      expect(about_page).not_to have_an_edit_link
    end

    context "when visiting as the owner" do
      before { about_page.visit_page_as user }

      it { expect(about_page).to have_an_edit_link }

      it { expect(about_page).to have_hostsite "github" }
      it { expect(about_page).to have_external_account_url "www.github.com/asdf" }

      it { expect(about_page).to have_hostsite "linkedin" }
      it { expect(about_page).to have_external_account_url "linkedin.com/asdf" }
    end
  end
end
