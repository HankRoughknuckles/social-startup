class ExternalAccount < ActiveRecord::Base
  belongs_to :user

  before_validation :strip_url!

  # removes the beginning "http://www." from self.url
  def strip_url!
    self.url = url
      .gsub("http://", "")
      .gsub("https://", "")
      .gsub("www.", "") unless self.url.nil?
  end

  # returns the array needed for the dropdown for selecting what hostsite
  # the external account belongs to
  def self.hostsite_options
    [
      ["", ""],
      ["Github", "Github"],
      ["Facebook", "Facebook"],
      ["Twitter", "Twitter"],
      ["Behance", "Behance"],
      ["500px", "500px"]
    ]
  end
end
