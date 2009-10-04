# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
#ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
	config.action_controller.session = { :key => "_juggleballs_session", :secret => "b27564d771382b05f600aba6eaf367f312acdcad358c74589c09240143c647a8e86dcbc4e004c84c85fa6d15dd0fdf9070c3540a8bac6e1ae21a261ba0a4193f" }
end
