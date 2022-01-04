# frozen_string_literal: true

# Class for logic menu
module Lib
  module Console
    class Menu
      include Validator
      MENU = %i[search_car fast_search show_car help log_in sign_up close].freeze
      MENU_AUTHORIZED = %i[search_car fast_search show_car my_searches help logout close].freeze
      MENU_ADMIN = %i[create update delete logout].freeze

      def initialize
        @console = Console.new
        @app = Lib::App.new
        @user = User.new
        @admin = Administrator.new
      end

      def welcome
        language = @console.input('menu.lang').downcase
        language = 'en' if language != 'uk'
        I18n.default_locale = :"#{language}"
        show_menu
      end

      def print_options
        @type_menu = @user.logged ? MENU_AUTHORIZED : MENU
        @type_menu = MENU_ADMIN if @user.admin
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
        return unless @user.logged

        UserSearches.write(@email, @user_rules)
      end

      def fast_search
        Operations::FastSearch.new.call
      end

      def show_car
        return @console.print_text('empty_database') unless @app.data

        @console.print_result(@app.show_car)
      end

      def sign_up
        return unless email
        return unless password

        @user.call(@email, @password)
        @console.text_with_params('user.login_welcome', @email)
      end

      def email
        @email = @console.input('input.user.email')
        return @console.print_text('user.incorrect_email') unless email?(@email)

        return @email unless @user.unique_email?(@email)

        @console.print_text('user.existing')
      end

      def password
        @password = @console.input('input.user.password')
        return @password if password?(@password)

        @console.print_text('user.incorrect_password')
      end

      def log_in
        @email = @console.input('input.user.email')
        password = @console.input('input.user.password')
        if @user.login(@email, password)
          @console.text_with_params('user.login_welcome', @email)
        else
          @console.print_text('user.uncorected_data', :light_green) unless @user.admin
        end
      end

      def help
        @console.print_help
      end

      def my_searches
        searches = UserSearches.exist_user?(@email)
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

      def logout
        @user.logout
        @console.print_text('menu.go_out', :light_green)
      end

      def close
        @console.print_text('menu.end')
        exit
      end
    end
  end
end
