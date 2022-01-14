# frozen_string_literal: true

# Class to call all the search and sort functionality
module Lib
  module Operations
    class SearchEngine
      attr_reader :data

      def initialize
        @console = Interface::Console.new
        @data = Database.new.read
      end

      def call
        search_rules
        sort_rules
        @console.print_statistic(sorter, statistic)
      end

      def show_car
        @data
      end

      private

      def search_rules
        @search_rules = @console.input_user_rules
      end

      def sort_rules
        @sort_rules = @console.input_sort_rules
      end

      def data_update_number
        Updater::DataUpdater.new(@search_rules.clone, @data).call('number')
      end

      def search
        @search = Operations::Searcher.new(data_update_number, @data.clone).call
      end

      def sorter
        Operations::Sorter.new(search, @sort_rules).call
      end

      def data_update_string
        Updater::DataUpdater.new(@search_rules, @data).call('string')
      end

      def statistic
        Operations::Statistic.new(data_update_string, @search.length).call
      end
    end
  end
end