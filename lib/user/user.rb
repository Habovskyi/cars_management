# frozen_string_literal: true

module Lib
  module User
    # Class for creating user
    class User
      include BCrypt

      def initialize
        @database = Database.new('user.yml')
      end

      def read_user
        @users = @database.read
      end

      def crypt_password(password)
        BCrypt::Password.create(password)
      end

      def write(user_data)
        @database.write(user_data)
      end

      def call(email, password)
        @credential = { email: email, password: crypt_password(password) }
        read_user ? add_new_user : write([@credential])
      end

      def add_new_user
        @users << @credential
        write(@users)
      end
    end
  end
end
