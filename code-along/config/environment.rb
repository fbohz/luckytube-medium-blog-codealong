ENV['SINATRA_ENV'] ||= "development"
require 'bundler/setup'
require "sinatra/activerecord"
Bundler.require(:default, ENV['SINATRA_ENV'])
#establish database connection
configure :development do
  set :database, 'sqlite3:db/my_database_name.db'
end
require_all './app'