# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Backend::Application.config.secret_key_base = 'b35ac3028ea802249d44194505d9bb5a67ac4f0837fd0591f99f41a8964a6bf34c89ced133013eefad6dd575dedcfcf87026157e7cc2fb9e8afba5b5e0cf14d0'
