desc "This task is run to generate some sample data"
task :generate_sample => :environment do
  start_date = 30.days.ago.to_date

  puts "Creating some data..."

  user = User.find_or_create_by!(username: "ascherman", email: "arielscherman@gmail.com") do |u|
    u.password = "123123"
    u.confirmed_at = 1.day.ago
  end

  currencies = Currency.all.index_by(&:symbol)
  rates      = Rate.all.index_by(&:key)

  initial_values = {
    "ars_in_dolar_blue" => 1/130.0,
    "btc_in_usd"        => 11_350
  }

  create_rate_values = proc do |rate_key, initial_value|
    last_value = initial_value

    (start_date..1.day.ago.to_date).each do |date|
      last_value *= rand(0.95..1.002)
      rates[rate_key].values.create!(date: date, value: last_value)
      print "."
    end
  end

  print "Rate Values"
  initial_values.each do |rate_key, initial_value|
    create_rate_values.call(rate_key, initial_value)
  end
  puts

  print "Depots"
  depot_ars = Depot.create!(name: "Billetera ARS",
                            user: user,
                            currency: currencies["ARS"],
                            rate: rates["ars_in_dolar_blue"],
                            cached_total_cents: 0)
  print "."

  depot_btc = Depot.create!(name: "Billetera BTC",
                            user: user,
                            currency: currencies["BTC"],
                            rate: rates["btc_in_usd"],
                            cached_total_cents: 0)
  print "."
  puts

  Depot::Movement.create!(depot: depot_ars, total_cents: 152_000_00, date: start_date)
  Depot::Movement.create!(depot: depot_btc, total_cents: 3_52, date: start_date)

  create_balances = proc do |depot, rate_key, initial_balance_in_cents|
    last_daily_balance = nil
    last_balance_in_cents = initial_balance_in_cents
    rates[rate_key].values.order(date: :asc).find_each do |rate_value|
      if rand(1..10) > 6
        new_balance_in_cents = last_balance_in_cents * rand(0.95..1.05)

        if rand(1..10) > 5
          Depot::Movement.create!(depot: depot, total_cents: last_balance_in_cents - new_balance_in_cents, date: rate_value.date)
        end

        last_balance_in_cents = new_balance_in_cents
      end

      last_daily_balance = depot.daily_balances.create!(date: rate_value.date,
                                                        cached_rate_value: rate_value.value,
                                                        previous_daily_balance: last_daily_balance,
                                                        cached_depot_total_in_cents: last_balance_in_cents)
      print "."
    end
    depot.update!(latest_daily_balance: last_daily_balance)
  end

  print "Daily balances"
  create_balances.call(depot_ars, "ars_in_dolar_blue", 152_000_00)
  create_balances.call(depot_btc, "btc_in_usd", 3_52)


  puts "done."
end
