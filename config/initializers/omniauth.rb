OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '193845660956059', '6027d4a0b571e9c39edfd0142dd5b1ab'
end
