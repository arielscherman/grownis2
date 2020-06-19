class AddKeyToRates < ActiveRecord::Migration[6.0]
  def change
    add_column :rates, :key, :string, null: false
  end
end
