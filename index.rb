# frozen_string_literal: true

require_relative 'lib/autoload'

database = Database.new.read_database
user_rules = Input.new.input_rules
update_user_rules = UpdateData.new(user_rules, database).value_update
sort_direction = Input.new.sort_direction
sort_option = Input.new.sort_option
result_searching = Searcher.new(update_user_rules, database).filter_rules
result_sorting = Sorter.new(result_searching, sort_direction, sort_option).sorting_option
Printer.new(result_sorting).call

