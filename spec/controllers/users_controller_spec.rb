require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "PATCH #update_about" do
    let!(:owner) { FactoryGirl.create(:user) }
    let!(:account) { FactoryGirl.create(:external_account, user: owner) }


    it "should let someone edit their own external accounts" do
      sign_in owner

      patch(:update_about, 
            "id" => owner.id, 
            "user" => {
              "external_accounts_attributes" => {
                "0" => {
                  "url" => "asdf.com", 
                  "id" => account.id
                }
              }
            })

      expect(account.reload.url).to eq "asdf.com"
    end


    it "should not let someone edit another's external accounts" do
      other_user = FactoryGirl.create(:user)
      sign_in other_user

      patch(:update_about, 
            "id" => owner.id, 
            "user" => {
              "external_accounts_attributes" => {
                "0" => {
                  "url" => "asdf.com", 
                  "id" => account.id
                }
              }
            })

      expect(account.reload.url).not_to eq "asdf.com"
    end
  end
end
