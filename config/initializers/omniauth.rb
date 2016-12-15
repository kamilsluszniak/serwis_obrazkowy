OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '110010476152745', 'ca5ca71f7dc4ec443be77afc6f8a9bd2', scope: 'email,public_profile', info_fields: 'name, email', :client_options => {:ssl => {:ca_file => Rails.root.join("cacert.pem").to_s}}
end