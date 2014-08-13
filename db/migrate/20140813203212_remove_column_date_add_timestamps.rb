class RemoveColumnDateAddTimestamps < ActiveRecord::Migration
  def change
    remove_column :sales, :date, :datetime
    add_column(:sales, :created_at, :datetime)
    add_column(:sales, :updated_at, :datetime)
  end
end
