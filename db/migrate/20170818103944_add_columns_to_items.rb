class AddColumnsToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :quantity, :integer
    add_column :items, :time_of_procurement, :integer
    add_column :items, :buffer_quantity, :integer
  end
end
