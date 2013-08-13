# Be sure to restart your server when you modify this file.

if Rails.env.development?
  Bonsaierp::Application.config.session_store :encrypted_cookie_store,
    key: '_bonsai_session', domain: ".#{DEV_DOMAIN}"
else
  Bonsaierp::Application.config.session_store :encrypted_cookie_store,
   key: '_bonsai_session', domain: ".#{DOMAIN}"
end

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# Bonsaierp::Application.config.session_store :active_record_store
