# frozen_string_literal: true

# Class for logic menu
module Lib
  module Interface
    class Menu
      include Validator
      MENU = %i[search_car fast_search show_car help log_in sign_up close].freeze
      MENU_AUTHORIZED = %i[search_car fast_search show_car my_searches help logout close].freeze
      MENU_ADMIN = %i[create update delete logout].freeze

      def initialize
        @console = Console.new
        @search = Operations::SearchEngine.new
        @user = User::User.new
        @admin = User::Administrator.new
        @authentication = User::Authentication.new
        @fast_search = Operations::FastSearch.new
      end

      def welcome
        select_language

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
        return @console.print_text('empty_database') unless @search.data

        @search.call

        return unless @authentication.logged

        User::Searches.write(@authentication.email, @user_rules)
      end

      def fast_search
        result = @fast_search.call

        return unless result

        return unless @authentication.logged && correct

        User::Searches.write(@authentication.email, @fast_search.user_rules)
      end

      def show_car
        return @console.print_text('empty_database') unless @search.data

        @console.print_result(@search.show_car)
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
        searches = User::Searches.exist_user?(@authentication.email)
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

      def select_language
        language = @console.input('menu.lang').downcase
        language = 'en' if language != 'uk'
        I18n.default_locale = :"#{language}"
      end
    end
  end
end
