class CreateAllotments < ActiveRecord::Migration[5.1]
  def change
    create_table :allotments do |t|
      t.references :item
      t.references :person
      t.string :status

      t.timestamps
    end
    add_index :allotments, [:item_id, :person_id]
  end
end
