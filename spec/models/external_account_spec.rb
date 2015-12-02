require 'rails_helper'

RSpec.describe ExternalAccount, :type => :model do
  describe "stripping the url" do
    [
      "http://www.google.com",
      "https://www.google.com",
      "http://google.com",
      "https://google.com",
      "www.google.com",
      "google.com"
    ].each do |url|
      it 'should strip http://www from the url on save' do
        new_url = ExternalAccount.create(url: url).url
        expect(new_url).to eq "google.com"
      end
    end
  end
end
