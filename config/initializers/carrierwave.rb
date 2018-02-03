CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['S3_IAM_ACCESS_KEY'],
      aws_secret_access_key: ENV['S3_IAM_SECRET_KEY'],
      region: 'ap-northeast-1'
  }

  case Rails.env
    when 'production'
      config.fog_directory = 'voice-db-production'
      config.asset_host = 'https://s3.ap-northeast-1.amazonaws.com/voice-db-production'

    when 'development'
      config.fog_directory = 'voice-db-development'
      config.asset_host = 'https://s3.ap-northeast-1.amazonaws.com/voice-db-development'
  end
end