require_relative "../spec_helper"

RSpec.describe "Fluxo Completo do Sistema" do

  let!(:vendedor) do
    Usuario.create!(
      nome: "Vendedor",
      email: "vendedor@email.com",
      senha_hash: "123456",
      cpf: "11111111111"
    )
  end

  let!(:comprador) do
    Usuario.create!(
      nome: "Comprador",
      email: "comprador@email.com",
      senha_hash: "123456",
      cpf: "22222222222"
    )
  end

  it "executa um fluxo completo de compra" do

    # Login do vendedor
    post "/login", {
      email: vendedor.email,
      senha: "123456"
    }

    # Cadastra um produto
    post "/produtos", {
      nome: "Mouse Gamer",
      descricao: "RGB",
      preco: 150,
      estoque: 5
    }

    produto = Produto.last

    expect(produto.nome).to eq("Mouse Gamer")

    # Logout
    get "/logout"

    # Login do comprador
    post "/login", {
      email: comprador.email,
      senha: "123456"
    }

    # Adiciona ao carrinho
    post "/carrinho/adicionar/#{produto.id}"

    # Finaliza compra
    post "/compras/finalizar"

    venda = Venda.last

    expect(venda).not_to be_nil
    expect(produto.reload.estoque).to eq(4)

    # Logout
    get "/logout"

    # Login do vendedor
    post "/login", {
      email: vendedor.email,
      senha: "123456"
    }

    # Atualiza o status até entregue
    post "/vendas/#{venda.id}/status"
    expect(venda.reload.status).to eq("paga")

    post "/vendas/#{venda.id}/status"
    expect(venda.reload.status).to eq("enviada")

    post "/vendas/#{venda.id}/status"
    expect(venda.reload.status).to eq("entregue")

  end

end