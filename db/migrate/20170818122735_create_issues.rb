class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.references :user
      t.references :item
      t.text :details
      t.string :status

      t.timestamps
    end
  end
end
