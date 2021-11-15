# frozen_string_literal: true

class Printer
  def initialize(result)
    @result = result
  end

  def print
    puts 'Results:'
    result.each do |car|
      car.each { |key, value| puts "#{key.capitalize}: #{value}" }
      puts
      puts '-' * 30
    end
  end

  private

  attr_reader :result
end
