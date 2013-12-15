Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID_DEV'], ENV['FACEBOOK_APP_SECRET_DEV']  
end