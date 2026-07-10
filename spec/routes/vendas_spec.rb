require_relative "../spec_helper"
require "bcrypt"

RSpec.describe "Rotas de Vendas" do

  let!(:comprador) do
    Usuario.create!(
      nome: "Comprador",
      email: "comprador@email.com",
      senha_hash: BCrypt::Password.create("123456"),
      cpf: "11111111111"
    )
  end

  let!(:vendedor) do
    Usuario.create!(
      nome: "Vendedor",
      email: "vendedor@email.com",
      senha_hash: BCrypt::Password.create("123456"),
      cpf: "22222222222"
    )
  end

  let!(:venda) do
    Venda.create!(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      status: "pendente",
      valor_total: 100
    )
  end

  before do

    post "/login", {
      email: vendedor.email,
      senha: "123456"
    }

  end

  it "avança o status da venda" do

    post "/vendas/#{venda.id}/status"

    expect(venda.reload.status).to eq("paga")

    post "/vendas/#{venda.id}/status"

    expect(venda.reload.status).to eq("enviada")

    post "/vendas/#{venda.id}/status"

    expect(venda.reload.status).to eq("entregue")

  end

end