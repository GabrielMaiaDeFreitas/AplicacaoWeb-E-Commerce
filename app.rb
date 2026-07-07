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
  usuario = Usuario.new(
    nome: "",
    email: "abc",
    cpf: "",
    senha_hash: ""
  )

  if usuario.valid?
    "Usuário válido!"
  else
    usuario.errors.full_messages.join("<br>")
  end
end