require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eventlite
  class Application < Rails::Application
    config.generators do |generate|
      generate.fixtures false
      generate.assets false
    end

    config.autoload_paths << File.expand_path('app/liquid', Rails.root)
    config.autoload_paths << File.expand_path('app/presenters', Rails.root)
  end
end
