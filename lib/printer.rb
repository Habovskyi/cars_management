# frozen_string_literal: true

# Class for printing result
class Printer
  MIN_LENGTH = 60

  def initialize(result, statistic)
    @result = result
    @statistic = statistic
  end

  def call
    statistic_data
    rows = []
    result.each do |car|
      car.each do |key, value|
        rows << [I18n.t("print.keys.#{key}").to_s.colorize(:green), value.to_s.colorize(:light_blue)]
      end
      rows << :separator
    end
    puts Terminal::Table.new(title: I18n.t('print.result').colorize(:light_white), rows: rows,
                             style: { width: search_size, border_bottom: false })
  end

  private

  def statistic_data
    table = Terminal::Table.new title: I18n.t('print.statistic').colorize(:light_white),
                                style: { width: search_size, border_bottom: false } do |t|
      t.add_row [I18n.t('print.total').colorize(:green), statistic[:total_quantity].to_s.colorize(:light_blue)]
      t.add_row [I18n.t('print.requests').colorize(:green), statistic[:requests_quantity].to_s.colorize(:light_blue)]
    end
    puts table
  end

  def search_size
    size = result.length.positive? ? result.max_by { |car| car['description'] }['description'].length + 25 : 0
    size < 45 ? MIN_LENGTH : size
  end

  attr_reader :result, :statistic
end
