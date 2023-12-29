require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "active_support"

require_relative "models/widget"

SQLITE_FILE = ENV["SQLITE_FILE_NAME"] || "app.sqlite3"
set :database, { adapter: "sqlite3", database: SQLITE_FILE }

enable :sessions

Time.zone = "UTC"

get "/" do
  @widgets = Widget.all.order(:created_at)

  erb :index
end

post "/widget" do
  Time.zone = "UTC"

  name = params[:name]
  if name.nil? || name == ""
    flash[:error] = "PLEASE ENTER YOUR NAME"
    redirect to("/")
    return
  end

  Widget.create!(name: name)
  redirect to("/")
end
