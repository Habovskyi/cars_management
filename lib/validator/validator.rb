# frozen_string_literal: true

# Class for validating data
module Lib
  module Validator
    INT_FIELD = %w[price year].freeze
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

    def int?(obj)
      /^[1-9]+[0-9]*$/.match?(obj)
    end

    def attribute?(rules)
      /^((make|model|year|price)=[a-zA-Z0-9]+)/.match?(rules)
    end

    def correct_value?(rules)
      rules.each do |key, value|
        return false if INT_FIELD.include?(key.to_s) && !int?(value)
      end
    end

    def menu?(type_menu, number)
      (/^[1-#{type_menu.size}]$/).match?(number)
    end

    def unique_email?(email, database)
      return unless database

      database.detect { |user| user[:email].eql? email }
    end
  end
end
