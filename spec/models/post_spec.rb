require 'rails_helper'

RSpec.describe Post, :type => :model do
  let(:owner) { FactoryGirl.create(:user) }
  let(:post) { FactoryGirl.create(:post, user: owner) }

  describe "variables" do
    it { expect(post).to respond_to :body }
  end
end
