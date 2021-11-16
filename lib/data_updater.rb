# frozen_string_literal: true

class DataUpdater
  def initialize(user_rules, database)
    @user_rules = user_rules
    @database = database
  end

  def call
    max_price = database.max_by { |car| car['price'] }['price']
    max_year = database.max_by { |car| car['year'] }['year'].freeze
    user_rules[:year_to] = max_year if user_rules[:year_to].to_i.zero?
    user_rules[:price_to] = max_price if user_rules[:price_to].to_i.zero?
    user_rules
  end

  private

  attr_reader :user_rules, :database
end
