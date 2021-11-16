# frozen_string_literal: true

# Class for updating user rules
class DataUpdater
  def initialize(user_rules, database)
    @user_rules = user_rules
    @database = database
  end

  def call
    change_max_value
    user_rules[:year_to] = @max_year if user_rules[:year_to].to_i.zero?
    user_rules[:price_to] = @max_price if user_rules[:price_to].to_i.zero?
    user_rules
  end

  private

  def change_max_value
    @max_price = database.max_by { |car| car['price'] }['price']
    @max_year = database.max_by { |car| car['year'] }['year']
  end

  attr_reader :user_rules, :database
end
