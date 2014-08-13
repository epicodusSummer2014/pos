class CreateCart < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.column :cost, :integer
    end
  end
end
