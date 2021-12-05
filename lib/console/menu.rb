# frozen_string_literal: true

# Class for logic menu
module Lib
  module Console
    class Menu
      def initialize
        @console = Console.new
        @app = Lib::App.new
      end

      def welcome
        language = @console.input('menu.lang')
        language = 'en' if language != 'uk'
        I18n.default_locale = :"#{language}"
        show_menu
      end

      def show_menu
        @console.print_menu
        loop do
          select_item
          @console.print_menu
        end
      end

      private

      def select_item
        case @console.input('menu.choice').to_i
        when 1 then search_car
        when 2 then show_car
        when 3 then @console.print_help
        when 4 then @console.print_text('menu.end')
                    exit
        else @console.print_text('menu.error')
        end
      end

      def search_car
        @app.search_rules(@console.input_user_rules)
        @app.sort_rules(@console.input_sort_rules)
        @console.print_statistic(@app.search, @app.statistic)
      end

      def show_car
        @console.print_result(@app.show_car)
      end
    end
  end
end
