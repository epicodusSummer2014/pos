class AddColumnToSaleCashierId < ActiveRecord::Migration
  def change
    add_column :sales, :cashier_id, :integer
  end
end
