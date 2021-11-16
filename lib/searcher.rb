# frozen_string_literal: true

class Searcher
  def initialize(user_rules, database)
    @user_rules = user_rules
    @database = database
  end

  def call
    user_rules.each do |user_key, user_value|
      compare(user_key, user_value)
    end
    database
  end

  private

  def compare(key, value)
    case key
    when :make, :model
      compare_string(key, value)
    when :year_from, :price_from
      compare_number_from(key, value)
    when :year_to, :price_to
      compare_number_to(key, value)
    else
      database
    end
  end

  def compare_string(key, value)
    database.select! { |cars| cars[key.to_s].casecmp(value).zero? }
  end

  def compare_number_to(key, value)
    database.select! { |cars| key == :year_to ? (cars['year'] <= value.to_i) : (cars['price'] <= value.to_i) }
  end

  def compare_number_from(key, value)
    database.select! { |cars| key == :year_from ? (cars['year'] >= value.to_i) : (cars['price'] >= value.to_i) }
  end

  attr_reader :user_rules, :database
end
