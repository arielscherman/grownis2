class MakeRateOptionalInDepots < ActiveRecord::Migration[6.0]
  def change
    change_column_null :depots, :rate_id, true
  end
end
