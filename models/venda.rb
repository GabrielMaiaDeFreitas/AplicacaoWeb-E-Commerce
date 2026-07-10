class Venda < ActiveRecord::Base
  belongs_to :comprador,
             class_name: 'Usuario',
             foreign_key: 'comprador_id'

  belongs_to :vendedor,
             class_name: 'Usuario',
             foreign_key: 'vendedor_id'

  validates :data, presence: true

  validates :status,
            presence: true,
            inclusion: {
              in: %w[pendente paga enviada entregue cancelada]
            }

  validates :valor_total,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }

  has_many :item_vendas,
           dependent: :destroy
end
