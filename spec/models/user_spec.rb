require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  describe "variables" do
    it { expect(user).to respond_to :email }
    it { expect(user).to respond_to :password }
    it { expect(user).to respond_to :first_name }
    it { expect(user).to respond_to :last_name }
    it { expect(user).to respond_to :full_name }
    it { expect(user).to respond_to :projects }
    it { expect(user).to respond_to :interests }
  end


  it 'should have a unique email' do
    user_1 = FactoryGirl.create(:user, email: "asdf@asdf.com")
    user_2 = FactoryGirl.build(:user, email: "asdf@asdf.com")

    expect(user_2).not_to be_valid
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% projects
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  describe "projects" do
    before { FactoryGirl.create(:project, user: user) }

    it { expect(user.projects.count).to eq 1 }

    it "should also get deleted when user is destroyed" do
      expect { user.destroy }.to change { Project.count }.by -1
    end
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% posts
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  describe "posts" do
    before { FactoryGirl.create(:post, user: user) }

    it { expect(user.posts.count).to eq 1 }

    it "should also get deleted when user is destroyed" do
      expect { user.destroy }.to change { Post.count }.by -1
    end
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% User#full_name
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  describe "#full_name" do
    it 'should show the first name and last name together' do
      user.first_name =   "James"
      user.last_name =    "McGaven"

      expect(user.full_name).to eq "James McGaven"
    end

    it 'should return an empty string if no name is present' do
      user.first_name =   ""
      user.last_name =    ""

      expect(user.full_name).to eq ""
    end

    it 'should only show first name if last name is blank' do
      user.first_name =   "James"
      user.last_name =    ""

      expect(user.full_name).to eq "James"
    end

    it 'should only show first name if last name is nil' do
      user.first_name =   "James"
      user.last_name =    nil

      expect(user.full_name).to eq "James"
    end

    it 'should only show last name if first name is blank' do
      user.first_name =   ""
      user.last_name =    "McGaven"

      expect(user.full_name).to eq "McGaven"
    end

    it 'should only show last name if first name is nil' do
      user.first_name =   nil
      user.last_name =    "McGaven"

      expect(user.full_name).to eq "McGaven"
    end
  end
end
