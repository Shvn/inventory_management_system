class CreateAllotmentHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :allotment_histories do |t|
      t.references :allotment
      t.string :action

      t.timestamps
    end
  end
end
