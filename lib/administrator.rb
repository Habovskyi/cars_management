# frozen_string_literal: true

# Class for admin operation
module Lib
  class Administrator
    include Validator
    ADVERTISEMENT_PARAMS = %w[make model year odometer price description date_added].freeze

    def initialize
      @database = Database.new('db.yml')
      @advertisement = @database.read || []
      @console = Console::Console.new
    end

    def write_advertisement(advertisement)
      @database.write(advertisement)
    end

    def create_advertisement
      car = { 'id' => id }
      ADVERTISEMENT_PARAMS.each do |key|
        return @console.print_text("admin.errors.#{key}") unless (car[key] = public_send(key))
      end
      @advertisement << car

      @database.write(@advertisement)

      @console.text_with_params('admin.messages.create', @current_id.to_s)
    end

    def update_advertisement
      return unless find_advertisement

      ADVERTISEMENT_PARAMS.each do |key|
        return @console.print_text("admin.errors.#{key}") unless (@current_advertisement[key] = public_send(key))
      end
      @database.write(@advertisement)

      @console.text_with_params('admin.messages.update', @id.to_s)
    end

    def delete_advertisement
      return unless find_advertisement

      @advertisement.delete(@current_advertisement)

      @database.write(@advertisement)

      @console.text_with_params('admin.messages.delete', @id.to_s)
    end

    def find_advertisement
      return unless input_id

      @current_advertisement = @advertisement.detect { |advertisement| advertisement['id'] == @id.to_i }
      @console.text_with_params('admin.errors.id', @id) unless @current_advertisement
      @current_advertisement
    end

    def input_id
      @id = @console.input('admin.car_params.id')
      return @console.print_text('admin.errors.id_no_numeric') unless int?(@id)

      @id
    end

    def id
      @current_id = @advertisement.empty? ? 1 : @advertisement.last['id'].to_i + 1
    end

    def make
      car_make = @console.input('admin.car_params.make')
      return unless make?(car_make)

      car_make
    end

    def model
      car_model = @console.input('admin.car_params.model')
      return unless make?(car_model)

      car_model
    end

    def year
      car_year = @console.input('admin.car_params.year')
      return unless year?(car_year)

      car_year.to_i
    end

    def price
      car_price = @console.input('admin.car_params.price')
      return unless odometer?(car_price)

      car_price.to_i
    end

    def odometer
      car_odometer = @console.input('admin.car_params.odometer')
      return unless odometer?(car_odometer)

      car_odometer.to_i
    end

    def description
      car_description = @console.input('admin.car_params.description')
      return unless description?(car_description)

      car_description
    end

    def date_added
      Date.today.strftime('%d/%m/%y')
    end
  end
end
