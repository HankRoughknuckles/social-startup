class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_taggable
  acts_as_taggable_on :interests

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


  def comma_separated_tag_list
    interest_list.to_s
  end
end
