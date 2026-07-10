require_relative '../spec_helper'

RSpec.describe 'Rotas de Usuários' do
  it 'abre a página inicial' do
    get '/'

    expect(last_response.status).to eq(200)
  end

  it 'abre o formulário de cadastro' do
    get '/usuarios/new'

    expect(last_response.status).to eq(200)
  end

  it 'cadastra um usuário' do
    expect do
      post '/usuarios', {

        nome: 'Gabriel',

        email: 'gabriel@email.com',

        senha: '123456',

        cpf: '12345678900',

        telefone: '62999999999'

      }
    end.to change { Usuario.count }.by(1)

    expect(last_response.status).to eq(302)
  end
end
