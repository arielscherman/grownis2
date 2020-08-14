class Charts::RatesController < ApplicationController
  layout false

  helper_method :placeholder_id

  def show
    @rate_values = rate.values.order(date: :asc)
    render :show, locals: { rate: rate, values: @rate_values, placeholder_id: params.require(:placeholder_id) }
  end

  private

  def rate
    @rate ||= Rate.find(params.require(:id))
  end
end
