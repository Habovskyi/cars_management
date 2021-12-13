# frozen_string_literal: true

# Class for logic menu
module Lib
  module Console
    class Menu
      MENU = %i[search_car show_car help log_in sign_up close].freeze
      MENU_AUTHORIZED = %i[search_car show_car help logout close].freeze

      def initialize
        @console = Console.new
        @app = Lib::App.new
        @user = User::User.new
        @validator = Validator::Validator.new
        @user_status = false
      end

      def welcome
        language = @console.input('menu.lang')
        language = 'en' if language != 'uk'
        I18n.default_locale = :"#{language}"
        show_menu
      end

      def print_options
        @type_menu = @user_status ? MENU_AUTHORIZED : MENU
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
        (/^[1-#{@type_menu.size}]*$/).match?(number) ? send(@type_menu[number.to_i - 1]) : @console.print_text('menu.error')
      end

      def search_car
        @app.search_rules(@console.input_user_rules)
        @app.sort_rules(@console.input_sort_rules)
        @console.print_statistic(@app.search, @app.statistic)
      end

      def show_car
        @console.print_result(@app.show_car)
      end

      def sign_up
        @email = @validator.email(@console.input('input.user.email'))
        @email ? @user.unique_email(@email) : nil
        @email ? @password = @validator.password(@console.input('input.user.password')) : nil
        @email && @password ? @console.print_text(@user.call(@email, @password), :light_green, @email) : nil
        @user_status = true
      end

      def log_in
        email = @console.input('input.user.email')
        password = @console.input('input.user.password')
        if @user.login(email, password)
          @console.print_text('user.successful_registration', :light_green, email)
          @user_status = true
        else
          @console.print_text('user.missing', :light_green)
        end
      end

      def help
        @console.print_help
      end

      def logout
        @user_status = false
        @console.print_text('menu.go_out', :light_green)
      end

      def close
        @console.print_text('menu.end')
        exit
      end
    end
  end
end
