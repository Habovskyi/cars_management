require_relative 'lib/autoload'

database = Database.new.read_database
user_rules = Input.new.input_rules
update_user_rules = UpdateData.new(user_rules, database).value_update
sort_direction = Input.new.sort_direction
sort_option = Input.new.sort_option
result_searching = SearchEngine.new(update_user_rules, database).filter
result_sorting = SortResult.new(result_searching, sort_direction, sort_option).sorting_option
PrintResult.new(result_sorting).print

