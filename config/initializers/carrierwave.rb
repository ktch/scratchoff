# ./config/initializers/carrierwave.rb
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider => "AWS",
    :aws_access_key_id => "AKIAIZ7HUQWHMG2TRQSQ",
    :aws_secret_access_key => "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",
  }
  config.fog_directory = "scratchoff"

  # use only one of the following 2 settings
  config.fog_host = "http://scratchoff.s3.amazonaws.com" # for no cloudfront
end