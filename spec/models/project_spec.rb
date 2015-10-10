require 'rails_helper'

RSpec.describe Project, :type => :model do
  let(:owner) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project, user: owner) }

  describe "variables" do
    it { expect(project).to respond_to :user }
  end
end
