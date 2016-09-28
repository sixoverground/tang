# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../spec/tang_app/config/environment', __FILE__)
run Rails.application
