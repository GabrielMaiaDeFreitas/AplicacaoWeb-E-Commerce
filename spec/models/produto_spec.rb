require_relative "../spec_helper"

RSpec.describe Produto do

  let(:vendedor) do
    Usuario.create!(
      nome: "Gabriel",
      email: "gabriel@email.com",
      senha_hash: "123456",
      cpf: "12345678900"
    )
  end

  it "cria um produto válido" do

    produto = Produto.new(
      nome: "Mouse",
      descricao: "Mouse Gamer",
      preco: 100,
      estoque: 10,
      vendedor: vendedor
    )

    expect(produto.valid?).to be true

  end

  it "exige nome" do

    produto = Produto.new(
      preco: 100,
      estoque: 10,
      vendedor: vendedor
    )

    expect(produto.valid?).to be false

  end

  it "exige preço" do

    produto = Produto.new(
      nome: "Mouse",
      estoque: 10,
      vendedor: vendedor
    )

    expect(produto.valid?).to be false

  end

  it "não aceita preço menor ou igual a zero" do

    produto = Produto.new(
      nome: "Mouse",
      preco: 0,
      estoque: 10,
      vendedor: vendedor
    )

    expect(produto.valid?).to be false

  end

  it "exige estoque" do

    produto = Produto.new(
      nome: "Mouse",
      preco: 100,
      vendedor: vendedor
    )

    expect(produto.valid?).to be false

  end

  it "não aceita estoque negativo" do

    produto = Produto.new(
      nome: "Mouse",
      preco: 100,
      estoque: -1,
      vendedor: vendedor
    )

    expect(produto.valid?).to be false

  end

end