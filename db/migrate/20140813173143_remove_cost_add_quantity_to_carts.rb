class RemoveCostAddQuantityToCarts < ActiveRecord::Migration
  def change
    remove_column :carts, :cost, :integer
    add_column :carts, :quantity, :integer
    remove_column :products, :quantity, :integer
  end
end
