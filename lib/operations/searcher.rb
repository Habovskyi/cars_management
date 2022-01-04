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
          @result = public_send(user_key, user_key, user_value) unless user_value.eql?('')
        end
        @result
      end

      def make(key, value)
        @result.select { |cars| cars[key.to_s].to_s.casecmp?(value) }
      end

      def model(key, value)
        @result.select { |cars| cars[key.to_s].to_s.casecmp?(value) }
      end

      def year_to(_key, value)
        @result.select { |cars| cars['year'].to_i <= value.to_i }
      end

      def year_from(_key, value)
        @result.select { |cars| cars['year'].to_i >= value.to_i }
      end

      def price_to(_key, value)
        @result.select { |cars| cars['price'].to_i <= value.to_i }
      end

      def price_from(_key, value)
        @result.select { |cars| cars['price'].to_i <= value.to_i }
      end
    end
  end
end
