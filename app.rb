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



# ==========================
# Produtos
# ==========================

get "/produtos/new" do

  redirect "/login" unless logado?

  @produto = Produto.new

  erb :"produtos/new"

end

post "/produtos" do

  redirect "/login" unless logado?

  @produto = Produto.new(
    nome: params[:nome],
    descricao: params[:descricao],
    preco: params[:preco],
    estoque: params[:estoque]
  )

  @produto.vendedor = usuario_logado

  if @produto.save

    session[:sucesso] = "Produto cadastrado com sucesso."

    redirect "/produtos"

  else

    erb :"produtos/new"

  end

end

get "/produtos" do

  redirect "/login" unless logado?

  @produtos = Produto.where(vendedor_id: usuario_logado.id)

  erb :"produtos/index"

end

get "/produtos/:id/edit" do

  redirect "/login" unless logado?

  @produto = Produto.find_by(
    id: params[:id],
    vendedor_id: usuario_logado.id
  )

  if @produto.nil?
    session[:erro] = "Produto não encontrado."

    redirect "/produtos"
  end

  erb :"produtos/edit"

end

post "/produtos/:id" do

  redirect "/login" unless logado?

  @produto = Produto.find_by(
    id: params[:id],
    vendedor_id: usuario_logado.id
  )

  if @produto.nil?
    session[:erro] = "Produto não encontrado."

    redirect "/produtos"
  end

  if @produto.update(
      nome: params[:nome],
      descricao: params[:descricao],
      preco: params[:preco],
      estoque: params[:estoque]
    )

    session[:sucesso] = "Produto atualizado com sucesso."

    redirect "/produtos"

  else

    erb :"produtos/edit"

  end

end

post "/produtos/:id/delete" do

  redirect "/login" unless logado?

  @produto = Produto.find_by(
    id: params[:id],
    vendedor_id: usuario_logado.id
  )

  if @produto.nil?

    session[:erro] = "Produto não encontrado."

    redirect "/produtos"

  end

  @produto.destroy

  session[:sucesso] = "Produto excluído com sucesso."

  redirect "/produtos"

end




# ==========================
# Catálogo
# ==========================

get "/catalogo" do

  redirect "/login" unless logado?

  @produtos = Produto.all

  erb :"produtos/catalogo"

end

get "/catalogo/:id" do

  redirect "/login" unless logado?

  @produto = Produto.find_by(id: params[:id])

  if @produto.nil?

    session[:erro] = "Produto não encontrado."

    redirect "/catalogo"

  end

  erb :"produtos/show"

end




# ==========================
# Carrinho
# ==========================

post "/carrinho/adicionar/:id" do

  redirect "/login" unless logado?

  produto = Produto.find_by(id: params[:id])

  if produto.nil?

    session[:erro] = "Produto não encontrado."

    redirect "/catalogo"

  end

  session[:carrinho] ||= {}

  id = produto.id.to_s

  if session[:carrinho][id]

    session[:carrinho][id] += 1

  else

    session[:carrinho][id] = 1

  end

  session[:sucesso] = "Produto adicionado ao carrinho."

  redirect "/catalogo/#{produto.id}"

end