class AddLatestValueToRates < ActiveRecord::Migration[6.0]
  def change
    add_reference :rates, :latest_value, type: :uuid, foreign_key: { to_table: :rate_values }

    rate_class = Class.new(ApplicationRecord) do
      self.table_name = "rates"
    end

    rate_value_class = Class.new(ApplicationRecord) do
      self.table_name = "rate_values"
    end

    rate_class.find_each do |rate|
      latest_value = rate_value_class.where(rate_id: rate.id).order(date: :desc).first
      rate.update!(latest_value_id: latest_value.id) if latest_value
    end
  end
end
