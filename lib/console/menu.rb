# frozen_string_literal: true

# Class for logic menu
module Lib
  module Console
    class Menu
      include Validators
      MENU = %i[search_car show_car help log_in sign_up close].freeze
      MENU_AUTHORIZED = %i[search_car show_car my_searches help logout close].freeze

      def initialize
        @console = Console.new
        @app = Lib::App.new
        @user = User.new
        @logged = false
      end

      def welcome
        language = @console.input('menu.lang').downcase
        language = 'en' if language != 'uk'
        I18n.default_locale = :"#{language}"
        show_menu
      end

      def print_options
        @type_menu = @logged ? MENU_AUTHORIZED : MENU
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
        if (/^[1-#{@type_menu.size}]$/).match(number)
          send(@type_menu[number.to_i - 1])
        else
          @console.print_text('menu.error')
        end
      end

      def search_car
        @user_rules = @console.input_user_rules
        @app.search_rules(@user_rules)
        @app.sort_rules(@console.input_sort_rules)
        @console.print_statistic(@app.search, @app.statistic)
        return unless @logged

        UserSearches.write(@email, @user_rules)
      end

      def show_car
        @console.print_result(@app.show_car)
      end

      def sign_up
        return unless email
        return unless password

        @user.call(@email, @password)
        @console.user_welcome(@email)
        @logged = true
      end

      def email
        @email = @console.input('input.user.email')
        unless email?(@email)
          @console.print_text('user.incorrect_email')
          return
        end

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
          @console.user_welcome(@email)
          @logged = true
        else
          @console.print_text('user.uncorected_data', :light_green)
        end
      end

      def help
        @console.print_help
      end

      def my_searches
        searches = UserSearches.exist_user?(@email)
        if searches
          @console.print_searches(searches[:user_rules])
        else
          @console.print_text('user_searches.no_searches')
        end
      end

      def logout
        @logged = false
        @console.print_text('menu.go_out', :light_green)
      end

      def close
        @console.print_text('menu.end')
        exit
      end
    end
  end
end
