# frozen_string_literal: true

require 'ffaker'
require 'yaml'
require 'i18n'
require 'colorize'
require_relative 'lib/database'
require_relative 'lib/console/console'

database = Lib::Database.new('db.yml')

namespace :car_database do
  desc 'Clearing the car database'
  task :clear do
    database.write(nil)
    puts 'The database has been cleared.'.colorize(:light_green)
  end

  desc 'Adding cars to the database(quantity - number of cars that will be added)'
  task :add_record, :quantity do |_, args|
    quantity = args.quantity || 1
    cars = database.read || []
    quantity.to_i.times do
      car = { 'id' => FFaker::Guid.guid.downcase,
              'make' => FFaker::Vehicle.make,
              'model' => FFaker::Vehicle.model,
              'year' => FFaker::Vehicle.year.to_i,
              'odometer' => FFaker::Random.rand(0..500_000).to_i,
              'price' => FFaker::Number.rand(10..1000) * 100.to_i,
              'description' => FFaker::Lorem.sentence,
              'date_added' => FFaker::Time.date.strftime('%d/%m/%y') }
      cars << car
    end
    database.write(cars)
    puts "#{quantity} cars were added to the database.".colorize(:light_green)
  end
end
