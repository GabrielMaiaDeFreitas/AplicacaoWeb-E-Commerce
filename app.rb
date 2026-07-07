require "sinatra"
require "sinatra/reloader" if development?

require_relative "config/database"

enable :sessions

get "/" do
  erb :index
end