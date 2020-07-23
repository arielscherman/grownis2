class CreateSuggestions < ActiveRecord::Migration[6.0]
  def change
    create_table :suggestions, id: :uuid do |t|
      t.text :description
      t.references :user, type: :uuid

      t.timestamps
    end
  end
end
