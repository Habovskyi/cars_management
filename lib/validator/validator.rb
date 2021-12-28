# frozen_string_literal: true

# Class for validating data
module Lib
  module Validator
    VALID_PASSWORD = /^(?=.*?[A-Z])(?=(?:.*?[()=\-\/\\+.,|#@$!%*?&]){2,}).{8,20}$/
    VALID_EMAIL = /^[a-z\d.]{5,}+@[a-z\d.]+\.[a-z]+/

    def password?(password)
      VALID_PASSWORD.match?(password)
    end

    def email?(email)
      VALID_EMAIL.match?(email)
    end

    def make?(make)
      /^([a-zA-Z]){3,50}$/.match?(make)
    end

    def year?(year)
      /^(\d{4})$/.match?(year) && (1900..Time.now.year).cover?(year.to_i)
    end

    def odometer?(odometer)
      /^\d+$/.match?(odometer) && odometer.to_i >= 0
    end

    def description?(description)
      /^([0-9a-zA-Z\s\W]){0,5000}$/.match?(description)
    end

    def int?(id)
      /^[1-9]+[0-9]*$/.match?(id)
    end
  end
end
