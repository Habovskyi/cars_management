# frozen_string_literal: true

# Class for updating user rules
module Lib
  module Updater
    class DataUpdater
      def initialize(user_rules, database)
        @user_rules = user_rules
        @database = database
      end

      def call(option_validate)
        option_validate == 'number' ? update_number : update_string
      end

      private

      def change_max_value
        set_max_price if @user_rules[:price_to].to_i <= 0
        set_max_year if @user_rules[:year_to].to_i <= 0
      end

      def set_max_price
        @user_rules[:price_to] = @database.max_by { |car| car['price'] }['price']
      end

      def set_max_year
        @user_rules[:year_to] = @database.max_by { |car| car['year'] }['year']
      end

      def update_number
        change_max_value
        @user_rules.delete_if { |_key, value| value.to_s.empty? }
      end

      def update_string
        @database.each do |cars|
          change_make(cars)
          change_model(cars)
        end
        @user_rules
      end

      def change_make(cars)
        @user_rules[:make] = cars['make'] if cars['make'].casecmp(@user_rules[:make]).zero?
      end

      def change_model(cars)
        @user_rules[:model] = cars['model'] if cars['model'].casecmp(@user_rules[:model]).zero?
      end
    end
  end
end
