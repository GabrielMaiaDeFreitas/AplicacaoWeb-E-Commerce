# Sistema de E-commerce com Sinatra e ActiveRecord

Projeto desenvolvido para a disciplina de **Programação Web** do **Instituto Federal de Goiás (IFG) – Campus Anápolis**.

A aplicação foi desenvolvida utilizando **Ruby**, **Sinatra**, **ActiveRecord** e **SQLite**, implementando um sistema simplificado de e-commerce no qual um mesmo usuário pode atuar como vendedor e comprador.

---

# Integrantes

- Gabriel Maia de Freitas

---

# Tecnologias Utilizadas

- Ruby
- Sinatra
- ActiveRecord
- SQLite3
- BCrypt
- ERB
- RSpec
- Rack::Test

---

# Dependências

Antes de executar o projeto, instale todas as dependências:

```bash
bundle install
```

---

# Preparação do Banco de Dados

Os arquivos dos bancos de dados (`*.sqlite3`) **não foram incluídos no projeto**, conforme solicitado no enunciado do trabalho.

Antes da primeira execução, crie o banco de desenvolvimento executando:

```bash
bundle exec rake db:migrate
```

Esse comando criará automaticamente o banco de dados **development.sqlite3** com todas as tabelas necessárias.

---

# Executando a Aplicação

Após criar o banco de dados, inicie o servidor com:

```bash
bundle exec ruby app.rb
```

Em seguida, acesse a aplicação pelo navegador:

```
http://localhost:9292
```

---

# Executando os Testes

O banco de testes (`test.sqlite3`) também não acompanha o projeto.

Antes de executar a suíte de testes pela primeira vez, crie a estrutura do banco executando:

```bash
RACK_ENV=test bundle exec rake db:migrate
```

Em seguida, execute todos os testes com:

```bash
bundle exec rspec
```

A suíte contempla testes de:

- Modelos
- Rotas
- Interface (Fluxo Completo)

---

# Funcionalidades Implementadas

## Usuário

- Cadastro de usuários
- Login
- Logout
- Edição do próprio perfil

## Vendedor

- Cadastro de produtos
- Edição de produtos
- Exclusão de produtos
- Listagem dos próprios produtos
- Consulta das vendas recebidas
- Atualização do status das vendas

## Comprador

- Catálogo de produtos
- Visualização dos detalhes dos produtos
- Adição de produtos ao carrinho
- Finalização de compras
- Histórico de compras
- Cancelamento de compras pendentes

---

# Segurança

As senhas dos usuários são armazenadas utilizando **BCrypt**, evitando o armazenamento em texto puro no banco de dados.

---

# Estrutura do Projeto

```
app/
db/
├── migrate/

helpers/
images/
models/
public/
spec/
views/

app.rb
config.ru
Gemfile
Gemfile.lock
README.md
```

---

# Capturas de Tela

## Cadastro de Usuário

![Tela de Cadastro](images/cadastro.png)

---

## Login

![Tela de Login](images/login.png)

---

## Catálogo de Produtos

![Tela de Catálogo de Produtos](images/catalogo-produtos.png)

---

## Carrinho de Compras

![Carrinho de Compras](images/carrinho.png)

---

## Finalizar Compra

![Finalizar Compra](images/finalizar-compras.png)

---

## Minhas Compras

![Minhas Compras](images/compras.png)

---

## Vendas Recebidas

![Vendas Recebidas](images/vendas.png)

---

# Observações

- O projeto utiliza ActiveRecord para persistência dos dados.
- O banco de dados utilizado é SQLite.
- As validações foram implementadas conforme especificado no enunciado.
- A finalização da compra utiliza transações para garantir a integridade dos dados.
- As senhas são armazenadas utilizando BCrypt.
- Os bancos de dados (`development.sqlite3` e `test.sqlite3`) não acompanham o projeto e são criados automaticamente durante a execução da aplicação e da suíte de testes.