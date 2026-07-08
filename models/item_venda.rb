class ItemVenda < ActiveRecord::Base
  belongs_to :venda

  belongs_to :produto

  validates :quantidade,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0
            }

  validates :preco_unitario,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
end