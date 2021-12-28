# frozen_string_literal: true

require 'ffaker'
require 'yaml'
require 'i18n'
require 'colorize'
require_relative 'lib/database'
require_relative 'config/i18n_config'
require_relative 'lib/console/console'

I18n.default_locale = :en

database = Lib::Database.new('db.yml')

namespace :car_database do
  desc 'Clearing the car database'
  task :clear do
    database.write(nil)
    puts I18n.t('rake.clear').colorize(:light_green)
  end

  desc 'Adding cars to the database(quantity - number of cars that will be added)'
  task :add_record, :quantity do |_, args|
    quantity = args.quantity || 1
    cars = database.read || []
    quantity.to_i.times do
      current_id = cars.empty? ? 1 : cars.last['id'].to_i + 1
      car = { 'id' => current_id,
              'make' => FFaker::Vehicle.make,
              'model' => FFaker::Vehicle.model,
              'year' => FFaker::Vehicle.year.to_i,
              'odometer' => FFaker::Number.rand(0..500_000).to_i,
              'price' => FFaker::Number.rand(10..1000) * 100.to_i,
              'description' => FFaker::Lorem.sentence,
              'date_added' => FFaker::Time.date.strftime('%d/%m/%y') }
      cars << car
    end

    database.write(cars)
    puts "#{quantity} #{I18n.t('rake.add_car')}".colorize(:light_green)
  end
end
