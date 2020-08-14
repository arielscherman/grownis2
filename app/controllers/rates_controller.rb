class RatesController < ApplicationController
  def show
    render :show, locals: { rate: rate }
  end

  private

  def rate
    @rate ||= Rate.find(params.require(:id))
  end
end
