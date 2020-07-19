class CreateCurrencyCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_categories, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
