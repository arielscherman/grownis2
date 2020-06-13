class AddDescriptionToDepotMovements < ActiveRecord::Migration[6.0]
  def change
    add_column :depot_movements, :description, :string
  end
end
