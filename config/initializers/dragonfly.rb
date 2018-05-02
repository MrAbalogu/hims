require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick
  plugin :avatarmagick

  secret "4838336d5fa1df4db550b46431dd3a9e2b61a4fcc6e5d4296bbd9e34bf4acb8b"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
