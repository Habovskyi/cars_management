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
        searches = { email: email, user_rules: [user_rules] }
        if exist_user?(email)
          @current_searches[:user_rules] << user_rules
        else
          @user_searches << searches
        end
        @database.write(@user_searches)
      end

      def exist_user?(email)
        @user_searches = read
        @current_searches = @user_searches.detect { |searches| searches[:email].eql? email }
      end
    end
  end
end
