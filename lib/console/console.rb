# frozen_string_literal: true

# Class for input and output data
module Lib
  module Console
    class Console
      def initialize
        @user_rules = { make: '',
                        model: '',
                        year_from: '',
                        year_to: '',
                        price_from: '',
                        price_to: '' }

        @sort_rules = { type: '',
                        direction: '' }
      end

      def input_user_rules
        print_text('input.search.select')
        @user_rules.each { |key, _| @user_rules[key] = input("input.search.rules.#{key}") }
        @user_rules
      end

      def input_sort_rules
        @sort_rules.each { |key, _| @sort_rules[key] = input("input.sort.#{key}") }
        @sort_rules
      end

      def input(text = '')
        print_text(text)
        gets.chomp
      end

      def print_text(text, color = :light_white)
        puts I18n.t(text.to_s).colorize(color.to_sym)
      end

      def text_with_params(text, param, color = :light_blue)
        puts I18n.t(text, param: param).colorize(color.to_sym)
      end

      def print_statistic(search_result, statistic)
        puts table(title: title('print.statistic', 'light_white'), rows: table_statistic(statistic))
        print_result(search_result)
      end

      def table_statistic(statistic)
        statistic.map { |key, value| [title("print.#{key}", 'light_green'), value.to_s] }
      end

      def print_result(search_result)
        result = search_result.flat_map { |car| table_car_data(car) << :separator }
        puts table(title: title('print.result', 'light_white'), rows: result, style: { border_bottom: false })
      end

      def print_searches(user_searches)
        result = user_searches.flat_map { |searches| table_searches_data(searches) << :separator }
        puts table(title: title('print.searches', 'light_white'), rows: result, style: { border_bottom: false })
      end

      def print_help
        help = { 'how_search' => 'ans_search', 'how_fast_search' => 'ans_fast_search', 'how_show' => 'ans_show',
                 'how_login' => 'ans_login', 'how_register' => 'ans_register', 'how_logout' => 'ans_logout',
                 'how_my_searches' => 'ans_my_searches', 'how_exit' => 'ans_exit' }
        puts table(title: title('menu.help', 'light_green'), rows: table_help(help))
      end

      def print_menu(menu)
        puts table(title: title('menu.name', 'light_white'), rows: table_menu(menu),
                   style: { border_bottom: true })
      end

      def table(title:, rows:, style: {})
        Terminal::Table.new(title: title, rows: rows, style: style)
      end

      def table_car_data(data)
        data.map { |key, value| [title("print.keys.#{key}", 'light_green'), value.to_s] }
      end

      def table_searches_data(data)
        data.map { |key, value| [title("user_searches.keys.#{key}", 'light_green'), value.to_s] }
      end

      def table_menu(menu)
        menu.map.with_index { |value, index| [(index + 1).to_s.colorize(:green), title("menu.#{value}")] }
      end

      def table_help(help)
        help.map { |key, value| [title("help.#{key}", 'light_blue'), title("help.#{value}")] }
      end

      def title(text, color = 'light_white')
        I18n.t(text.to_s).colorize(:"#{color}")
      end
    end
  end
end
