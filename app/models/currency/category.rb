class Currency::Category < ApplicationRecord
  has_many :currencies, inverse_of: :category, foreign_key: :currency_category_id
end
