class Api::RatesController < Api::ApplicationController
  def index
    render json: Rate.where(currency_id: currency_id)
  end

  private

  def currency_id
    params.require(:currency_id)
  end
end
