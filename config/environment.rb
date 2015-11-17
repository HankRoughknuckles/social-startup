# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Make Amazon S3 work with bucket in the EU
AWS::S3::DEFAULT_HOST = "s3-eu-west-1.amazonaws.com"

# Initialize the Rails application.
Rails.application.initialize!
