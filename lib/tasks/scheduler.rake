desc "This task is run to get rate prices and generate daily balances"
task :generate_daily_balances => :environment do
  puts "Creating daily balances..."
  Depot::DailyBalance::Generator.new.generate!
  puts "done."
end
