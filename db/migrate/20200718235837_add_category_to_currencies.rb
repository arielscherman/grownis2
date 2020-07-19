class AddCategoryToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_reference :currencies, :currency_category, type: :uuid, null: false, foreign_key: true
  end
end
