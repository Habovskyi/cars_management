# frozen_string_literal: true

# Class for updating user rules
class DataUpdater
  def initialize(user_rules, database)
    @user_rules = user_rules
    @database = database
  end

  def call(option_validate)
    option_validate == 'number' ? validate_number : validate_string
  end

  private

  def validate_number
    change_max_value
    user_rules[:year_to] = @max_year if user_rules[:year_to].to_i.zero?
    user_rules[:price_to] = @max_price if user_rules[:price_to].to_i.zero?
    user_rules.delete_if { |_key, value| value == '' }
    user_rules
  end

  def validate_string
    database.each do |cars|
      user_rules[:make] = cars['make'] if cars['make'].casecmp(user_rules[:make]).zero?
      user_rules[:model] = cars['model'] if cars['model'].casecmp(user_rules[:model]).zero?
    end
    user_rules
  end

  def change_max_value
    @max_price = database.max_by { |car| car['price'] }['price']
    @max_year = database.max_by { |car| car['year'] }['year']
  end

  attr_reader :user_rules, :database
end
