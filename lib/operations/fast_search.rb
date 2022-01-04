# frozen_string_literal: true

# Class for fast searching result
module Lib
  module Operations
    class FastSearch
      include Validator

      def initialize
        @database = Database.new.read
        @user = User.new
        @console = Console::Console.new
        @rules = { make: '',
                   model: '',
                   year_from: '',
                   year_to: '',
                   price_from: '',
                   price_to: '' }
      end

      def call
        return unless update_rules

        result_fast_search = Operations::Searcher.new(@rules, @database).call

        statistic = Operations::Statistic.new(@rules, result_fast_search.length).call
        @console.print_statistic(result_fast_search, statistic)
        return unless @user.logged

        UserSearches.write(@email, @rules)
      end

      private

      def update_rules
        fast_rules = @console.input('input.search.fast')
        return @console.print_text('input.search.error') unless fast_search?(fast_rules)

        search_rules = string_to_hash(fast_rules)
        return @console.print_text('input.search.error_format') unless correct_value?(search_rules)

        transform_hash(search_rules)
      end

      def string_to_hash(fast_rules)
        fast_rules = fast_rules.tr(';', ' ').tr('=', ' ').split
        Hash[*fast_rules].transform_keys(&:to_sym)
      end

      def transform_hash(search_rules)
        @rules[:year_to] = search_rules[:year] if search_rules.key?(:year)
        @rules[:price_to] = search_rules[:price] if search_rules.key?(:price)
        search_rules.delete_if { |k, _v| %i[year price].include?(k) }
        @rules = @rules.merge(search_rules)
      end
    end
  end
end
