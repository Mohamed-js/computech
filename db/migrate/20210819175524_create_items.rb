class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :buying_price

      t.timestamps
    end
  end
end
