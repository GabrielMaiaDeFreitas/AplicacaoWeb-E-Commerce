require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/activerecord"

enable :sessions

set :database, {
  adapter: "sqlite3",
  database: "db/development.sqlite3"
}

Dir["./models/*.rb"].each { |file| require file }

get "/" do
  erb :index
end