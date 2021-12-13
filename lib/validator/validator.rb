# frozen_string_literal: true

# Class for validating data
module Lib
  module Validator
    class Validator

      VALID_PASSWORD = /^(?=.*[a-z])(?=.*[A-Z])(?=(?:.*?[@$!%*?&]){2,})[A-Za-z\d@$!%*?&]{8,20}$/
      VALID_EMAIL = /^[a-z\d.]{5,}+@[a-z\d.]+\.[a-z]+/

      def initialize
        @console = Console::Console.new
      end

      def password(password)
        VALID_PASSWORD.match?(password) ? password : @console.print_text('incorrect_password')
      end

      def email(email)
        VALID_EMAIL.match?(email) ? email : @console.print_text('incorrect_email')
      end
    end
  end
end
