# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_token is kept private
# if you're sharing your code publicly.
Plutus::Application.config.secret_token = 'c2f99eca4e54463887db778322ad87a5ddfed7fc8b3813bbe78a5b1a962235c5a661fa5701ace67ef0270b2e3dacd5b40d646660fec751abc7fec775b51e9e69'
