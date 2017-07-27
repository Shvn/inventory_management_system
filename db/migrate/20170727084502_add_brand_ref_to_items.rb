class AddBrandRefToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :brand, foreign_key: true
  end
end
