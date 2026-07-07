class Produto < ActiveRecord::Base
  validates :nome, presence: true

  validates :preco,
            presence: true,
            numericality: { greater_than: 0 }

  validates :estoque,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  belongs_to :vendedor,
             class_name: "Usuario",
             foreign_key: "vendedor_id"
end