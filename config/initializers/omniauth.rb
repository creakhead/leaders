OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '124485634388792', '17155f57efc198b46644a549122e2a4a'
end