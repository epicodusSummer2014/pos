class RemoveCustomersAddSale < ActiveRecord::Migration
  def change
    drop_table :customers
    create_table :sales do |t|
    end
  end
end
