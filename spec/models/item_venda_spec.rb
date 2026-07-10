require_relative "../spec_helper"
require "bcrypt"

RSpec.describe ItemVenda do

  let(:comprador) do
    Usuario.create!(
      nome: "Comprador",
      email: "comprador@email.com",
      senha_hash: BCrypt::Password.create("123456"),
      cpf: "11111111111"
    )
  end

  let(:vendedor) do
    Usuario.create!(
      nome: "Vendedor",
      email: "vendedor@email.com",
      senha_hash: BCrypt::Password.create("123456"),
      cpf: "22222222222"
    )
  end

  let(:produto) do
    Produto.create!(
      nome: "Mouse",
      descricao: "Mouse Gamer",
      preco: 100,
      estoque: 10,
      vendedor: vendedor
    )
  end

  let(:venda) do
    Venda.create!(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      status: "pendente",
      valor_total: 100
    )
  end

  it "cria um item de venda válido" do

    item = ItemVenda.new(
      venda: venda,
      produto: produto,
      quantidade: 2,
      preco_unitario: 100
    )

    expect(item.valid?).to be true

  end

  it "exige quantidade" do

    item = ItemVenda.new(
      venda: venda,
      produto: produto,
      preco_unitario: 100
    )

    expect(item.valid?).to be false

  end

  it "não aceita quantidade menor ou igual a zero" do

    item = ItemVenda.new(
      venda: venda,
      produto: produto,
      quantidade: 0,
      preco_unitario: 100
    )

    expect(item.valid?).to be false

  end

  it "exige preço unitário" do

    item = ItemVenda.new(
      venda: venda,
      produto: produto,
      quantidade: 2
    )

    expect(item.valid?).to be false

  end

  it "não aceita preço unitário negativo" do

    item = ItemVenda.new(
      venda: venda,
      produto: produto,
      quantidade: 2,
      preco_unitario: -10
    )

    expect(item.valid?).to be false

  end

end