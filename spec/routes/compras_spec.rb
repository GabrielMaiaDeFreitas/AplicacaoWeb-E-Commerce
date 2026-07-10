require_relative "../spec_helper"

RSpec.describe "Rotas de Compras" do

  let!(:comprador) do
    Usuario.create!(
      nome: "Comprador",
      email: "comprador@email.com",
      senha_hash: "123456",
      cpf: "11111111111"
    )
  end

  let!(:vendedor) do
    Usuario.create!(
      nome: "Vendedor",
      email: "vendedor@email.com",
      senha_hash: "123456",
      cpf: "22222222222"
    )
  end

  let!(:produto) do
    Produto.create!(
      nome: "Mouse",
      descricao: "Mouse Gamer",
      preco: 100,
      estoque: 10,
      vendedor: vendedor
    )
  end

  before do

    post "/login", {
      email: comprador.email,
      senha: "123456"
    }

  end

  it "finaliza uma compra e debita o estoque" do

    post "/carrinho/adicionar/#{produto.id}"

    expect {

      post "/compras/finalizar"

    }.to change { Venda.count }.by(1)
     .and change { ItemVenda.count }.by(1)

    expect(produto.reload.estoque).to eq(9)

    expect(last_response.status).to eq(302)

  end

end