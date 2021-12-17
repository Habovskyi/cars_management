# frozen_string_literal: true

module Lib
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

    def unique_email?(email)
      return unless read_user

      @users.detect { |user| user[:email].eql? email }
    end

    def add_new_user
      @users << @credential
      write(@users)
    end

    def login(email, password)
      return unless read_user

      @users.detect { |user| user[:email] == email && user[:password] == password }
    end
  end
end
