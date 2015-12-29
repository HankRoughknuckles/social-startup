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

  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% User#add_interest
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  describe "#add_interest" do
    it "should create a new interests_users record" do
      expect { user.add_interest("bugs") }
        .to change { InterestsUser.count }.by 1
    end

    it "should create a new interest record if none exists" do
      expect { user.add_interest("bugs") }
        .to change { Interest.count }.by 1
    end

    context "when the interest already exists" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { other_user.add_interest("bugs") }

      it "should not create a new interest record" do
        expect { user.add_interest("bugs") }
          .to change { Interest.count }.by 0
      end

      it "should not create a new interest regardless of letter case" do
        expect { user.add_interest("BUgs") }
          .to change { Interest.count }.by 0
      end
    end
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% User#remove_interest
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  describe "#remove_interest" do
    before { user.add_interest "bugs" }

    it "should delete the interest_users when removing" do
      expect { user.remove_interest("bugs") }
        .to change { InterestsUser.count }.by -1
    end

    it "should not delete the interest if other user has it" do
      other_user = FactoryGirl.create(:user)
      other_user.add_interest "bugs"

      expect { user.remove_interest("bugs") }
        .to change { Interest.count }.by 0
    end

    it "should delete the interest if no other user has it" do
      expect { user.remove_interest("bugs") }
        .to change { Interest.count }.by -1
    end
  end


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% User#add_interests_from_json
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  describe "#add_interests_from_json" do
    it "should add a single interest" do
      user.add_interests_from_json '["cats"]'
      expect(user.reload.interests.find_by_name "Cats").to be_present
    end

    it "should add a multiple interests" do
      expect { 
        user.add_interests_from_json('["cats", "plants", "loneliness"]')
      }.to change { user.interests.count }.by 3
    end

    it "should not add existing interests" do
      user.add_interest "ants"

      expect { 
        user.add_interests_from_json('["ants", "plants"]')
      }.to change { user.interests.count }.by 1
    end

    it "should only add one interest if duplicates occur in input" do
      expect { 
        user.add_interests_from_json('["ants", "ants"]')
      }.to change { user.interests.count }.by 1
    end

    it "shouldn't add anything for non-json input" do
      expect { user.add_interests_from_json '[cats]' }
        .to change { user.interests.count }.by 0
    end
  end
end
