class Post < ActiveRecord::Base
  belongs_to :user

  validates :body, presence: true, allow_blank: false
end
