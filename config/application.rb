require_relative 'boot'

require 'rails/all'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
require "view_component/engine"

module Grownis2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.i18n.default_locale = :es
    config.time_zone = "America/Argentina/Buenos_Aires"

    config.active_job.queue_adapter = :sidekiq

    config.exceptions_app = self.routes
  end
end
