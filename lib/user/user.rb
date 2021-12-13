# frozen_string_literal: true

module Lib
  module User
    class User
      include BCrypt

      def initialize
        @database = Database.new('user.yml', 'a+')
      end

      def read_user
        @users = @database.read
      end

      def crypt_password(password)
        BCrypt::Password.create(password)
      end

      def write_user(user_data)
        @database.write(user_data)
        'user.successful_registration'
      end

      def call(email, password)
        @credential = { email: email, password: crypt_password(password) }
        read_user ? add_new_user : write_user([@credential])
      end

      def unique_email(email)
        (@users.detect { |user| user[:email].eql? email } ? 'user.existing' : email) if @users
      end

      def add_new_user
        @users << @credential
        write_user(@users)
      end

      def login(email, password)
        return 'user.missing' unless read_user

        @users.detect do |user|
          return true if user[:email] == email && user[:password] == password
        end
      end
    end
  end
end
