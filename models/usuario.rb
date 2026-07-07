require "uri"


class Usuario < ActiveRecord::Base
  validates :nome, presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :cpf, presence: true

  validates :senha_hash, presence: true
end