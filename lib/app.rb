# frozen_string_literal: true

require_relative 'autoload'
# Class to call all the functionality
class App
  def initialize
    @data = Database.new.read
    @input = Input.new
  end

  def call
    return puts I18n.t('empty_database') unless data

    Printer.new(sorter, statistic).call
  end

  private

  def read_database
    database.read
  end

  def input_user_rules
    @user_rules = input.call
  end

  def data_update_number
    DataUpdater.new(input_user_rules.clone, data).call('number')
  end

  def sort_option
    input.sort_option
  end

  def sort_direction
    input.sort_direction
  end

  def search
    @search = Searcher.new(data_update_number, data).call
  end

  def sorter
    @sorter = Sorter.new(search, sort_direction, sort_option).call
  end

  def data_update_string
    DataUpdater.new(@user_rules, data).call('string')
  end

  def statistic
    Statistic.new(data_update_string, @search.length).call
  end

  attr_reader :database, :input, :data
end
