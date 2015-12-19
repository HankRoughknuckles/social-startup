class Project < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, allow_blank: false


  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Images
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  has_attached_file :project_image, 
    styles: { 
      medium: "300x300>", 
      thumb: "100x100>" 
    },
    s3_host_name: "s3.eu-central-1.amazonaws.com",
    default_url: ":style/default_project_image.jpg"


  validates_attachment_content_type :project_image, 
    content_type: /\Aimage\/.*\Z/
end
