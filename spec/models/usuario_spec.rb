require_relative '../spec_helper'
require 'bcrypt'

RSpec.describe Usuario do
  it 'cria um usuário válido' do
    usuario = Usuario.new(
      nome: 'Gabriel',
      email: 'gabriel@email.com',
      senha_hash: BCrypt::Password.create('123456'),
      cpf: '12345678900'
    )

    expect(usuario.valid?).to be true
  end

  it 'exige nome' do
    usuario = Usuario.new(
      email: 'gabriel@email.com',
      senha_hash: BCrypt::Password.create('123456'),
      cpf: '12345678900'
    )

    expect(usuario.valid?).to be false
  end

  it 'exige email' do
    usuario = Usuario.new(
      nome: 'Gabriel',
      senha_hash: '123456',
      cpf: '12345678900'
    )

    expect(usuario.valid?).to be false
  end

  it 'aceita apenas email válido' do
    usuario = Usuario.new(
      nome: 'Gabriel',
      email: 'email_invalido',
      senha_hash: '123456',
      cpf: '12345678900'
    )

    expect(usuario.valid?).to be false
  end

  it 'não permite email duplicado' do
    Usuario.create!(
      nome: 'Gabriel',
      email: 'gabriel@email.com',
      senha_hash: '123456',
      cpf: '12345678900'
    )

    usuario = Usuario.new(
      nome: 'João',
      email: 'gabriel@email.com',
      senha_hash: '654321',
      cpf: '99999999999'
    )

    expect(usuario.valid?).to be false
  end

  it 'exige CPF' do
    usuario = Usuario.new(
      nome: 'Gabriel',
      email: 'gabriel@email.com',
      senha_hash: '123456'
    )

    expect(usuario.valid?).to be false
  end

  it 'exige senha' do
    usuario = Usuario.new(
      nome: 'Gabriel',
      email: 'gabriel@email.com',
      cpf: '12345678900'
    )

    expect(usuario.valid?).to be false
  end
end
