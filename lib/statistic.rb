# frozen_string_literal: true

# Class for calculating statistics
class Statistic
  DB_NAME = 'searches.yml'
  DEFAULT_REQUEST_COUNTER = 1

  def initialize(user_rules, result_searching, database)
    @user_rules = user_rules
    @result_searching = result_searching
    @database = database
  end

  def load_statistic
    @data = Database.new.call(DB_NAME)
  end

  def call
    if load_statistic == false
      @statistic = [{ search: user_rules, statistic: create_statistic }]
      Database.new.write(@statistic, DB_NAME)
    else
      unique_record
    end
    create_statistic
  end

  private

  def unique_record
    @data.each do |request|
      if request[:search] == user_rules
        request[:statistic][:requests_quantity] = request_counter
        @check = true
      end
    end
    add_new_record unless @check
    write_statistic
  end

  def add_new_record
    @statistic = { search: @user_rules, statistic: create_statistic }
    @data << @statistic
  end

  def create_statistic
    @quantity = { total_quantity: total_counter, requests_quantity: @count || 1 }
  end

  def write_statistic
    Database.new.write(@data, DB_NAME)
  end

  def total_counter
    result_searching.length
  end

  def request_counter
    @data.each do |request|
      @count = request.dig(:statistic, :requests_quantity) + 1 if request[:search] == user_rules
    end
    @count
  end

  attr_reader :user_rules, :result_searching, :database
end
