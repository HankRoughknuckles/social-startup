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


  it 'should be accessible from the about page' do
    main_edit_page = UserAboutPage.new(user)

    main_edit_page.visit_page_as user
    main_edit_page.click_edit_about_link

    expect(page.title).to eq edit_page.title
  end


  describe "The page contents" do
    before { edit_page.visit_page_as user }

    it { expect(edit_page).to have_account_host_dropdown }
    it { expect(edit_page).to have_account_url_input }
    it { expect(edit_page).to have_interests_input }


    describe "adding an external account" do
      it "should work when url is present" do
        expect{ 
          edit_page.submit_external_account hostsite: "Github", url: "bags"
        }.to change { user.external_accounts.count }.by 1
      end


      it "should not add anything if url is blank" do
        expect{ edit_page.click_submit_button }
          .to change { user.external_accounts.count }.by 0
      end
    end


    describe "interests" do
      it "should add interests" do
        edit_page.fill_interests("ants, marbles")

        expect { edit_page.click_submit_button }
          .to change { user.reload.interest_list.count }.by 2
      end


      it "should remove interests that aren't present in text_field" do
        user.interest_list.add "ants"

        edit_page.fill_interests("")
        edit_page.click_submit_button 

        expect(user.reload.interest_list.count).to eq 0
      end
    end
  end
end

