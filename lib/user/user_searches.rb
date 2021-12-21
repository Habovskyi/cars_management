# frozen_string_literal: true

module Lib
  # Class to handle user searches
  class UserSearches
    class << self
      def read
        @database = Database.new('user_searches.yml')
        @database.read || []
      end

      def write(email, user_rules)
        current_user_search = search_date(user_rules.dup)
        searches = { email: email, user_rules: [current_user_search] }

        if exist_user?(email)
          @current_searches[:user_rules] << current_user_search
        else
          @user_searches << searches
        end
        @database.write(@user_searches)
      end

      def exist_user?(email)
        @current_searches = @user_searches.detect { |searches| searches[:email].eql? email } if (@user_searches = read)
      end

      def search_date(rules)
        rules[:search_date] = Time.new.strftime('%d/%m/%Y %k:%M:%S')
        rules
      end
    end
  end
end
