class CreateUserMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_messages, id: :uuid do |t|
      t.references :user, type: :uuid
      t.text :description
      t.boolean :acknowledged, default: false

      t.timestamps
    end
  end
end
