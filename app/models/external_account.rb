class ExternalAccount < ActiveRecord::Base
  belongs_to :user

  before_validation :strip_url!

  def strip_url!
    self.url = url
      .gsub("http://", "")
      .gsub("https://", "")
      .gsub("www.", "") unless self.url.nil?
  end
end
