# frozen_string_literal: true

# Class for calculating statistics
class Statistic
  DB_NAME = 'searches.yml'

  def initialize(user_rules, result_searching)
    @user_rules = user_rules
    @result_searching = result_searching
    @db = Database.new(DB_NAME)
    @statistic = { search: user_rules, statistic: { total_quantity: total_counter, requests_quantity: 1} }
  end

  def call
    load_statistic == false ? @db.write([@statistic]) : unique_record
    @statistic
  end

  private

  def load_statistic
    @data = @db.read
  end

  def unique_record
    @data.each do |request|
      if request[:search] == user_rules
        request[:statistic][:requests_quantity] += 1
        @check = true
      end
    end
    add_new_record unless @check
    @db.write(@data)
  end

  def add_new_record
    @data << @statistic
  end

  def total_counter
    result_searching.length
  end

  attr_reader :user_rules, :result_searching
end
