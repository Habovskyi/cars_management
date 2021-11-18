# frozen_string_literal: true

# Class for inputting search(user) rules
class Input
  def initialize
    @user_rules = { make: '',
                    model: '',
                    year_from: '',
                    year_to: '',
                    price_from: '',
                    price_to: '' }
  end

  def call
    puts 'Please select search rules.'
    user_rules.each do |key, _value|
      puts "Please choose #{key}: "
      user_rules[key] = gets.chomp
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
