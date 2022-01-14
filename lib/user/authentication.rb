# frozen_string_literal: true

# class for authentication logic
module Lib
  module User
    class Authentication
      include Validator
      attr_reader :logged, :admin, :email

      def initialize
        @console = Interface::Console.new
        @user = User.new
        @database = Database.new('user.yml')
      end

      def read_user
        @users = @database.read
      end

      def sign_up
        return unless input_email
        return unless input_password

        @user.call(@email, @password)
        @logged = true
        @console.text_with_params('user.login_welcome', @email)
      end

      def log_in
        @email = @console.input('input.user.email')
        password = @console.input('input.user.password')

        if find_user(@email, password)
          @logged = true
          @console.text_with_params('user.login_welcome', @email)
        else
          @console.print_text('user.uncorected_data', :light_green) unless @admin
        end
      end

      def logout
        @logged = false
        @admin = false
      end

      private

      def input_email
        @email = @console.input('input.user.email')

        return @console.print_text('user.incorrect_email') unless email?(@email)

        return @email unless unique_email?(@email, read_user)

        @console.print_text('user.existing')
      end

      def input_password
        @password = @console.input('input.user.password')
        return @password if password?(@password)

        @console.print_text('user.incorrect_password')
      end

      def find_user(email, password)
        return unless read_user

        return if (@admin = admin?(email, password))

        @users.detect { |user| user[:email] == email && user[:password] == password }
      end

      def admin?(email, password)
        email == 'admin' && password == 'admin'
      end
    end
  end
end
