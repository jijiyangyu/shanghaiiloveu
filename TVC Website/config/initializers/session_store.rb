# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shanghaiiloveu_session',
  :secret      => 'caab4ce7fcc1ad5e20de09804c940c71a563b9986a7e2c23aca10498313380a045f822a388dfe3d8dc066a92537672e3a437d547e1b29cd8397d5372d1ffd42a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
