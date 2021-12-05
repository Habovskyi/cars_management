# frozen_string_literal: true

# Class for sorting result
module Lib
  module Operations
    class Sorter
      SORT_DIRECTION = 'asc'
      SORT_TYPE = 'price'

      def initialize(data, sorter_rules)
        @data = data
        @sorter_rules = sorter_rules
      end

      def call
        @sorter_rules[:type] == SORT_TYPE ? sorting_by_price : sorting_by_date_added
      end

      private

      def sorting_by_price
        @data.sort_by! { |car| car['price'] }
        @sorter_rules[:direction] == SORT_DIRECTION ? @data : @data.reverse
      end

      def sorting_by_date_added
        @data.sort_by! { |car| Date.strptime(car['date_added'], '%d/%m/%y') }
        @sorter_rules[:direction] == SORT_DIRECTION ? @data : @data.reverse
      end
    end
  end
end
