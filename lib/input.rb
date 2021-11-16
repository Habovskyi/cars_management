class Input
  def initialize
    @user_rules = { 'make': ' ',
                    'model': ' ',
                    'year_from': 0,
                    'year_to': 0,
                    'price_from': 0,
                    'price_to': 0 }
  end

  def call
    puts 'Please select search rules.'
    user_rules.each do |key, value|
      puts "Please choose #{key}: "
      user_rules[key] = gets.chomp
      user_rules.delete_if { |key, value| value == '' }
    end
    user_rules
  end

  def sort_direction
    puts 'Please choose sort direction(desc|asc):'
    gets.chomp
  end

  def sort_option
    puts 'Please choose sort option (date_added|price):'
    gets.chomp
  end

  private

  attr_reader :user_rules
end
