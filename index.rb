# frozen_string_literal: true

require_relative 'lib/autoload'

database = Database.new.read_database
user_rules = Input.new.call
update_user_rules = DataUpdater.new(user_rules, database).call
sort_direction = Input.new.sort_direction
sort_option = Input.new.sort_option
result_searching = Searcher.new(update_user_rules, database).call
result_sorting = Sorter.new(result_searching, sort_direction, sort_option).call
Printer.new(result_sorting).call
