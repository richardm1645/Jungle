class Calculator
  def add(*numbers)
    numbers.inject(0) { |sum, number| sum + number }
  end
end