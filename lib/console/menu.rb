# frozen_string_literal: true

# Class for logic menu
module Lib
  module Console
    class Menu
      include Validator
      MENU = %i[search_car fast_search show_car help log_in sign_up close].freeze
      MENU_AUTHORIZED = %i[search_car fast_search show_car my_searches help logout close].freeze
      MENU_ADMIN = %i[create update delete logout].freeze
      ATTEMPT = 5

      def initialize
        @console = Console.new
        @app = Lib::App.new
        @user = User.new
        @admin = Administrator.new
        @authentication = Authentication.new
        @fast_search = Operations::FastSearch.new
      end

      def welcome
        language = @console.input('menu.lang').downcase
        language = 'en' if language != 'uk'
        I18n.default_locale = :"#{language}"
        show_menu
      end

      def print_options
        @type_menu = @authentication.logged ? MENU_AUTHORIZED : MENU
        @type_menu = MENU_ADMIN if @authentication.admin
        @console.print_menu(@type_menu)
      end

      def show_menu
        print_options
        loop do
          select_item
          print_options
        end
      end

      private

      def select_item
        number = @console.input('menu.choice')
        menu?(@type_menu, number) ? send(@type_menu[number.to_i - 1]) : @console.print_text('menu.error')
      end

      def search_car
        return @console.print_text('empty_database') unless @app.data

        @user_rules = @console.input_user_rules
        @app.search_rules(@user_rules)
        @app.sort_rules(@console.input_sort_rules)
        @console.print_statistic(@app.sorter, @app.statistic)
        return unless @authentication.logged

        UserSearches.write(@authentication.email, @user_rules)
      end

      def fast_search
        correct = false
        count = 0

        until correct
          correct = @fast_search.call
          @console.text_with_params('input.search.attempt', (ATTEMPT - count += 1)) unless correct

          return @console.print_text('input.search.attempt_end', 'light_red') if count.eql?(ATTEMPT)
        end

        return unless @authentication.logged && correct

        UserSearches.write(@authentication.email, @fast_search.user_rules)
      end

      def show_car
        return @console.print_text('empty_database') unless @app.data

        @console.print_result(@app.show_car)
      end

      def sign_up
        @authentication.sign_up
      end

      def log_in
        @authentication.log_in
      end

      def logout
        @authentication.logout
        @console.print_text('menu.go_out', :light_green)
      end

      def help
        @console.print_help
      end

      def my_searches
        searches = UserSearches.exist_user?(@authentication.email)
        searches ? @console.print_searches(searches[:user_rules]) : @console.print_text('user_searches.no_searches')
      end

      def create
        @admin.create_advertisement
      end

      def update
        @admin.update_advertisement
      end

      def delete
        @admin.delete_advertisement
      end

      def close
        @console.print_text('menu.end')
        exit
      end
    end
  end
end
