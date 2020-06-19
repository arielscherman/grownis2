class CreateRates < ActiveRecord::Migration[6.0]
  def change
    create_table :rates do |t|
      t.string :name

      t.timestamps
    end
  end
end
