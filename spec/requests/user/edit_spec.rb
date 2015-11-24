require "spec_helper"

describe "Edit User Registration Page" do
  let(:user) { FactoryGirl.create(:user) }
  let(:edit_page) { UserEditPage.new user }

  before { edit_page.visit_page_as user }

  it { expect(edit_page).to have_profile_picture }
  it { expect(edit_page).to have_first_name_input }
  it { expect(edit_page).to have_last_name_input }


  describe "updating information" do
    # first name
    it 'should update the first name when present' do
      edit_page.submit_form first_name: "Chupacabra", current_password: user.password
      expect(user.reload.first_name).to eq "Chupacabra"
    end
    
    it 'should not update the first name when blank' do
      edit_page.submit_form first_name: "", current_password: user.password
      expect(user.reload.first_name).not_to eq ""
    end


    it 'should update the last name when present' do
      edit_page.submit_form last_name: "Bushmaster", current_password: user.password

      expect(user.reload.last_name).to eq "Bushmaster"
    end
  end
end
