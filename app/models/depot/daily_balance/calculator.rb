class Depot::DailyBalance::Calculator
  def variation_between(before, after)
    return 0.0 if after.to_f.zero? || before.to_f.zero?
    (((after / before.to_d) - 1) * 100).to_f
  end
end
