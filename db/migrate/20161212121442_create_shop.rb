class CreateShop < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :shop_name
      t.string :address
      t.integer :shop_seq
    end
    add_index :shops, :shop_seq, unique: true
  end
end
