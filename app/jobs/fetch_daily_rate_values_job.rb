class FetchDailyRateValuesJob < ApplicationJob
  queue_as :default

  def perform
    Depot::DailyBalance::Generator.new.generate!
  end
end
