# frozen_string_literal: true

class Sorter
  SORT_DIRECTION = 'asc'
  SORT_TYPE = 'price'

  def initialize(data, direction, type)
    @data = data
    @direction = direction
    @type = type
  end

  def call
    type == SORT_TYPE ? sorting_by_price : sorting_by_date_added
  end

  def sorting_by_price
    data.sort_by! { |car| car['price'] }
    direction == SORT_DIRECTION ? data : data.reverse
  end

  def sorting_by_date_added
    data.sort_by! { |car| Date.strptime(car['date_added'], '%d/%m/%y') }
    direction == SORT_DIRECTION ? data : data.reverse
  end

  private

  attr_reader :data, :direction, :type
end

