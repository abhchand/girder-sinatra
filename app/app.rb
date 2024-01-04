require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "active_support"

require "pathname"

ENV['RACK_ENV'] ||= 'development'

APP_ROOT = Pathname.new(File.expand_path("..", __dir__))
SQLITE_FILE = ENV["SQLITE_FILE_NAME"] || "app.#{ENV['RACK_ENV']}.sqlite3"

## Application Configuration

set :database, { adapter: "sqlite3", database: SQLITE_FILE }
enable :sessions

Time.zone = "UTC"

# Application Resources

Dir[APP_ROOT.join("app", "models", "*")].each { |model| require model }
Dir[APP_ROOT.join("app", "controllers", "*")].each { |controller| require controller }
