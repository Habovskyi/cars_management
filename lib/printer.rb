# frozen_string_literal: true

# Class for printing results
class Printer
  def initialize(result)
    @result = result
  end

  def call(statistic)
    statistic(statistic)
    puts 'Results:'
    result.each do |car|
      car.each { |key, value| puts "#{key.capitalize}: #{value}" }
      puts '-' * 30
    end
  end

  def statistic(statistic)
    puts '-' * 30
    puts 'Statistic:'
    puts "Total Quantity: #{statistic[:total_quantity]}"
    puts "Requests Quantity: #{statistic[:requests_quantity]}"
    puts '-' * 30
  end

  private

  attr_reader :result
end
