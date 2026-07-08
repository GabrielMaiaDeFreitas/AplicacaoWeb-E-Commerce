require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/activerecord"

enable :sessions

set :database, {
  adapter: "sqlite3",
  database: "db/development.sqlite3"
}

Dir["./models/*.rb"].each { |file| require file }
require_relative "helpers/autenticacao_helper"

helpers AutenticacaoHelper

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
    session[:sucesso] = "Usuário cadastrado com sucesso!"

    redirect "/"
  else
    erb :"usuarios/new"
  end

end



# ==========================
# Lista de usuários
# ==========================

get "/usuarios" do
  @usuarios = Usuario.all
  erb :"usuarios/index"
end



# ==========================
# Login
# ==========================

get "/login" do
  erb :"autenticacao/login"
end

post "/login" do

  usuario = Usuario.find_by(email: params[:email])

  if usuario && usuario.senha_hash == params[:senha]

    session[:usuario_id] = usuario.id

    session[:sucesso] = "Login realizado com sucesso!"

    redirect "/"

  else

    session[:erro] = "Email ou senha inválidos."

    redirect "/login"

  end

end

get "/logout" do

  session.clear

  session[:sucesso] = "Logout realizado com sucesso."

  redirect "/"

end


# ==========================
# Perfil
# ==========================

get "/perfil" do

  redirect "/login" unless logado?

  @usuario = usuario_logado

  erb :"autenticacao/perfil"

end

post "/perfil" do

  redirect "/login" unless logado?

  @usuario = usuario_logado

  if @usuario.update(
      nome: params[:nome],
      email: params[:email],
      senha_hash: params[:senha],
      cpf: params[:cpf],
      telefone: params[:telefone]
    )

    session[:sucesso] = "Perfil atualizado com sucesso."

    redirect "/"

  else

    erb :"autenticacao/perfil"

  end

end