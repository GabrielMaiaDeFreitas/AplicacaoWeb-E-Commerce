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

# ==========================
# Cadastro de usuários
# ==========================

get "/usuarios/new" do
  @usuario = Usuario.new
  erb :"usuarios/new"
end

post "/usuarios" do
  @usuario = Usuario.new(
    nome: params[:nome],
    email: params[:email],
    senha_hash: params[:senha_hash],
    cpf: params[:cpf],
    telefone: params[:telefone]
  )

  if @usuario.save
    redirect "/"
  else
    erb :"usuarios/new"
  end
end