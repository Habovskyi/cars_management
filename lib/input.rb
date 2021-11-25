# frozen_string_literal: true

# Class for inputting search(user) rules
class Input
  def initialize
    @user_rules = { make: '',
                    model: '',
                    year_from: '',
                    year_to: '',
                    price_from: '',
                    price_to: '' }
  end

  def call
    puts I18n.t('input.search_rules.select')
    user_rules.each do |key, _value|
      puts "#{I18n.t('input.search_rules.choose')} #{I18n.t("input.search_rules.keys.#{key}")}:"
      user_rules[key] = gets.chomp
    end
    user_rules
  end

  def sort_direction
    puts I18n.t('input.search_sort.direction')
    gets.chomp
  end

  def sort_option
    puts I18n.t('input.search_sort.type')
    gets.chomp
  end

  private

  attr_reader :user_rules
end
