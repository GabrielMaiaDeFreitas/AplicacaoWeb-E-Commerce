class CreateProdutos < ActiveRecord::Migration[8.1]
  def change
    create_table :produtos do |t|
      t.string :nome, null: false
      t.text :descricao
      t.decimal :preco, precision: 10, scale: 2, null: false
      t.integer :estoque, null: false
      t.references :vendedor, null: false, foreign_key: { to_table: :usuarios }

      t.timestamps
    end
  end
end
