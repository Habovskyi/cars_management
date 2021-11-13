class Printer
  attr_reader :result

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
end
