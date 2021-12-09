# frozen_string_literal: true

# Class for calculating statistics
module Lib
  module Operations
    class Statistic
      DB_NAME = 'searches.yml'

      def initialize(user_rules, count)
        @user_rules = user_rules
        @db = Database.new(DB_NAME)
        @statistic = { search: user_rules, statistic: { total_quantity: count, requests_quantity: 1 } }
      end

      def call
        load_statistic ? unique_record : @db.write([@statistic])
        @statistic[:statistic]
      end

      private

      def load_statistic
        @data = @db.read
      end

      def unique_record
        @data.each do |request|
          next unless request[:search] == @user_rules

          @statistic[:statistic][:requests_quantity] = request[:statistic][:requests_quantity] += 1
          @check = true
        end
        add_new_record unless @check
        @db.write(@data)
      end

      def add_new_record
        @data << @statistic
      end
    end
  end
end
