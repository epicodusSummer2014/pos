class AddColumnDateToSales < ActiveRecord::Migration
  def change
    add_column :sales, :date, :datetime
  end
end
