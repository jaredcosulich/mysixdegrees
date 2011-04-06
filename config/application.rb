require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'pp'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module OmniauthDeviseExample
  class Application < Rails::Application
    attr_accessor :cache_buster, :host

    config.generators do |g|
      g.template_engine :haml
      g.test_framework :rspec
      g.helper false
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.before_initialize do
      Rails.application.host = "#{(Rails.env.production? ? '' : "#{Rails.env}.")}mysixdegrees.me"

      Dir["#{Rails.root}/lib/ruby_ext/*.rb"].sort.each do |file|
        require file
      end

      ActiveSupport::Deprecation.silenced = true
#      ActiveSupport::Deprecation.debug = true

      Rails.application.cache_buster = Time.now.to_i
      ::S3_PAPERCLIP_STORAGE_OPTIONS = {
        :storage => :s3,
        :s3_credentials => "#{Rails.root}/config/s3.yml",
        :s3_host_alias => 'photos.mysixdegrees.me',
        :s3_headers => {'Expires' => 1.year.from_now.httpdate},
        :bucket => 'photos.mysixdegrees.me',
        :url => ":s3_alias_url",
        :path => "#{Rails.env}/:id/:style"
      }

      ::LOCAL_PAPERCLIP_STORAGE_OPTIONS = {
        :url => "/system/attachments/:attachment/:id/:style/:filename"
      }
    end
  end
end
