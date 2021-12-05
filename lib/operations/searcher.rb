# frozen_string_literal: true

# Class for searching records
module Lib
  module Operations
    class Searcher
      def initialize(user_rules, database)
        @user_rules = user_rules
        @database = database
      end

      def call
        @result = @database
        @user_rules.each do |user_key, user_value|
          @result = compare(user_key, user_value)
        end
        @result
      end

      private

      def compare(key, value)
        case key
        when :make, :model
          compare_string(key, value)
        when :year_from, :price_from
          compare_number_from(key, value)
        when :year_to, :price_to
          compare_number_to(key, value)
        else
          @result
        end
      end

      def compare_string(key, value)
        @result.select { |cars| cars[key.to_s].casecmp(value).zero? }
      end

      def compare_number_to(key, value)
        @result.select { |cars| key == :year_to ? (cars['year'] <= value.to_i) : (cars['price'] <= value.to_i) }
      end

      def compare_number_from(key, value)
        @result.select { |cars| key == :year_from ? (cars['year'] >= value.to_i) : (cars['price'] >= value.to_i) }
      end
    end
  end
end
