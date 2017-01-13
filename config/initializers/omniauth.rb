OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_APP_SECRET'], scope: 'email,public_profile', info_fields: 'name, email', :client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
end