require "spec_helper"

describe "The edit about page" do
  let(:user) { FactoryGirl.create(:user) }
  let(:edit_page) { EditAboutPage.new user }

  it 'should be accessible from the edit user registration page' do
    main_edit_page = UserEditPage.new(user)

    main_edit_page.visit_page_as user
    main_edit_page.click_edit_about_link

    expect(page.title).to eq edit_page.title
  end
end
