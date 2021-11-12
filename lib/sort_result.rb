class SortResult
  attr_reader :data, :direction, :type

  SORT_DIRECTION_DEFAULT = 'asc'.freeze
  SORT_TYPE_DEFAULT = 'date_added'.freeze

  def initialize(data, direction, type)
    @data = data
    @direction = direction
    @type = type
  end

  def sorting_option
    type == SORT_TYPE_DEFAULT ? sorting_by_date_added : sorting_by_price
  end

  def sorting_by_price
    data.sort_by! { |car| car['price'] }
    direction == SORT_DIRECTION_DEFAULT ? data : data.reverse
  end

  def sorting_by_date_added
    data.sort_by! { |car| Date.strptime(car['date_added'], '%d/%m/%y') }
    direction == SORT_DIRECTION_DEFAULT ? data : data.reverse
  end
end

