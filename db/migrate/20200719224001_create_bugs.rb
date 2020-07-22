class CreateBugs < ActiveRecord::Migration[6.0]
  def change
    create_table :bugs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.references :user, type: :uuid

      t.timestamps
    end
  end
end
