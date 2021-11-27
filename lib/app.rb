# frozen_string_literal: true

require_relative 'autoload'
# Class to call all the functionality
class App
  def self.call
    database = Database.new.read
    return puts I18n.t('empty_database') unless database

    user_rules = Input.new.call
    update_user_rules = DataUpdater.new(user_rules.clone, database).call('number')
    sort_option = Input.new.sort_option
    sort_direction = Input.new.sort_direction
    result_searching = Searcher.new(update_user_rules, database).call
    result_sorting = Sorter.new(result_searching, sort_direction, sort_option).call
    user_rules = DataUpdater.new(user_rules, result_searching).call('string')
    statistic = Statistic.new(user_rules, result_sorting.length).call
    Printer.new(result_sorting, statistic).call
  end
end
