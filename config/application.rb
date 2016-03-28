require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module My
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

#    config.assets.digest = true

    config.autoload_paths << Rails.root.join('lib')

=begin
    class TestMiddleware
      def initialize(app)
        @app = app
      end
      def call(env)
        puts "in TestMiddleware"
        env['rack.session']['QQQQQ 2']='WWWWW 2'
#        p env['rack.session']
        env['rack.session'].keys.each do |k|
          puts "#{k} : #{env['rack.session'][k]}"
        end
#        env["action_dispatch.request.unsigned_session_cookie"].keys.each do |k|
#          puts "#{k} : #{env['rack.session'][k]}"
#        end
        p env['rack.session']['warden.user.user.key']
#        get_cookie(env).keys.each do |k|
#          puts "#{k} : #{env['rack.session'][k]}"
#        end
        $env = env
        p $env['rack.session']['warden.user.user.key']
        byebug
        @app.call(env)
      end
    end
=end
#    config.middleware.use TestMiddleware
#   config.middleware.insert_after ActionDispatch::Session::CookieStore, TestMiddleware
#   config.middleware.insert_after Rack::ETag, TestMiddleware

  end
end
