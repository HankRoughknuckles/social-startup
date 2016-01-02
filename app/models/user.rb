require "json"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Images
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  has_attached_file :profile_picture, 
    styles: { 
      medium: "300x300>", 
      thumb: "100x100>" 
    },
    s3_host_name: "s3.eu-central-1.amazonaws.com",
    default_url: ":style/default_profile_pic.png"


  validates_attachment_content_type :profile_picture, 
    content_type: /\Aimage\/.*\Z/


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Database relations
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  has_many :projects, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :external_accounts, dependent: :destroy
  has_many :interests_users
  has_many :interests, through: :interests_users

  accepts_nested_attributes_for :external_accounts, 
    reject_if: lambda {|account| account[:url].blank?},
    allow_destroy: true


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Validations
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  validates_presence_of :first_name


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Instance methods
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  def full_name
    (first_name.to_s + " " + last_name.to_s).strip
  end


  # Adds a new interest to the user by interest name (case-insensitive).
  # Will create a new Interest record if none exists.
  def add_interest interest_name
    interest_name = Interest.capitalize_first interest_name
    interests << Interest.find_or_create_by(name: interest_name)
  end


  # Takes json for an array of strings and adds each to the user's
  # interests
  def set_interests_from_json json_interest_names
    begin
      # TODO: this could get expensive - could be made better by creating
      # a hash of names and seeing if hash has the value
      existing = self.interests.pluck(:name)
      JSON.parse(json_interest_names).each do |interest_name|
        interest_name = Interest.capitalize_first interest_name
        unless existing.include? interest_name
          add_interest(interest_name)
          existing << interest_name
        end
      end
    rescue 
    end
  end


  # Removes the interest for the user.  Deletes the interest entirely if
  # no one else has it.
  def remove_interest interest_name
    interest_name = Interest.capitalize_first interest_name
    interest = Interest.find_by_name interest_name
    self.interests.delete interest
    interest.destroy unless interest.users.any?
  end
end
