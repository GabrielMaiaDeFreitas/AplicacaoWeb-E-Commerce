require_relative "../spec_helper"
require "bcrypt"

RSpec.describe "Rotas de Produtos" do

  let!(:usuario) do
    Usuario.create!(
      nome: "Gabriel",
      email: "gabriel@email.com",
      senha_hash: BCrypt::Password.create("123456"),
      cpf: "12345678900"
    )
  end

  before do
    post "/login", {
      email: usuario.email,
      senha: "123456"
    }
  end

  it "abre a listagem de produtos" do

    get "/produtos"

    expect(last_response.status).to eq(200)

  end

  it "abre o formulário de cadastro" do

    get "/produtos/new"

    expect(last_response.status).to eq(200)

  end

  it "cadastra um produto" do

    expect {

      post "/produtos", {

        nome: "Mouse Gamer",

        descricao: "Mouse RGB",

        preco: 150,

        estoque: 5

      }

    }.to change { Produto.count }.by(1)

    expect(last_response.status).to eq(302)

  end

end