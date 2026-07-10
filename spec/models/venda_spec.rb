require_relative '../spec_helper'
require 'bcrypt'

RSpec.describe Venda do
  let(:comprador) do
    Usuario.create!(
      nome: 'Comprador',
      email: 'comprador@email.com',
      senha_hash: BCrypt::Password.create('123456'),
      cpf: '11111111111'
    )
  end

  let(:vendedor) do
    Usuario.create!(
      nome: 'Vendedor',
      email: 'vendedor@email.com',
      senha_hash: BCrypt::Password.create('123456'),
      cpf: '22222222222'
    )
  end

  it 'cria uma venda válida' do
    venda = Venda.new(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      status: 'pendente',
      valor_total: 100
    )

    expect(venda.valid?).to be true
  end

  it 'exige data' do
    venda = Venda.new(
      comprador: comprador,
      vendedor: vendedor,
      status: 'pendente',
      valor_total: 100
    )

    expect(venda.valid?).to be false
  end

  it 'exige status' do
    venda = Venda.new(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      valor_total: 100
    )

    expect(venda.valid?).to be false
  end

  it 'aceita apenas status válidos' do
    venda = Venda.new(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      status: 'qualquer',
      valor_total: 100
    )

    expect(venda.valid?).to be false
  end

  it 'exige valor total' do
    venda = Venda.new(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      status: 'pendente'
    )

    expect(venda.valid?).to be false
  end

  it 'não aceita valor total negativo' do
    venda = Venda.new(
      comprador: comprador,
      vendedor: vendedor,
      data: Date.today,
      status: 'pendente',
      valor_total: -10
    )

    expect(venda.valid?).to be false
  end
end
