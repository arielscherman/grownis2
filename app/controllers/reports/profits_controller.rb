class Reports::ProfitsController < ApplicationController
  def index
    render :index, locals: { start_date: 1.month.ago.to_date, end_date: Date.today }
  end
end
