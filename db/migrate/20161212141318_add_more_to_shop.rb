class AddMoreToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :shop_desc, :string
    add_column :shops, :allow_stack_cnt, :int
  end
end
