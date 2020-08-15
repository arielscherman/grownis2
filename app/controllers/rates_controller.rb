class RatesController < ApplicationController
  def index
    render :index, locals: { rates: Rate.includes(:currency, :to_currency, latest_value: :rate).order(:name) }
  end

  def show
    render :show, locals: { rate: rate }
  end

  private

  def rate
    @rate ||= Rate.find(params.require(:id))
  end
end
