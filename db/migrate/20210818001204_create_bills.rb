class CreateBills < ActiveRecord::Migration[6.1]
  def change
    create_table :bills do |t|
      t.integer :total
      t.integer :discount

      t.timestamps
    end
  end
end
