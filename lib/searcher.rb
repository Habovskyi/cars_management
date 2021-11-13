class Searcher
  attr_reader :user_rules, :database

  def initialize(user_rules, database)
    @user_rules = user_rules
    @database = database
  end

  def filter_rules
    user_rules.each do |user_key, user_value|
      compare(user_key, user_value)
    end
    database
  end

  def compare(key, value)
    case key
    when :make, :model
      database.select! { |cars| cars[key.to_s].casecmp(value).zero? }
    when :year_from, :price_from
      database.select! { |cars| key == :year_from ? (cars['year'] >= value.to_i) : (cars['price'] >= value.to_i) }
    when :year_to, :price_to
      database.select! { |cars| key == :year_to ? (cars['year'] <= value.to_i) : (cars['price'] <= value.to_i) }
    else
      database
    end
  end
end

