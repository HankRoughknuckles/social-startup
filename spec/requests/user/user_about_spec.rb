require "spec_helper"

describe "About User Page" do
  let(:user) { FactoryGirl.create(:user) }
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
    end
  end
end
