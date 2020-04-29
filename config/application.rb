require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
# require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Covid19brInfo
  class Application < Rails::Application
    config.action_controller.action_on_unpermitted_parameters = :raise
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.x.cloudinary_enabled = ENV.fetch("CLOUDINARY_URL") { raise "Missing CLOUDINARY_URL" if Rails.env.production? }.present?
    config.x.sidekiq_user = ENV.fetch("SIDEKIQ_USERNAME") { raise "Missing SIDEKIQ_USERNAME" if Rails.env.production? }
    config.x.sidekiq_password = ENV.fetch("SIDEKIQ_PASSWORD") { raise "Missing SIDEKIQ_PASSWORD" if Rails.env.production? }
  end
end
