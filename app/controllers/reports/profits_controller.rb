class Reports::ProfitsController < ApplicationController
  before_action :authenticate_user!

  def index
    render :index, locals: { start_date: 1.month.ago.to_date, end_date: Date.current }
  end
end
