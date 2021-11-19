# frozen_string_literal: true

# Class for working with database
class Database
  FILEPATH = File.dirname(__FILE__)
  NAME_DB = 'db.yml'

  def initialize(name_db = NAME_DB)
    @name = name_db
    create_file unless File.file?(path)
    @db = File.open(path, 'r+')
  end

  def read
    YAML.load_file(path)
  end

  def write(data)
    @db.write(data.to_yaml)
    @db.close
  end

  private

  def create_file
    File.new(path, 'w')
  end

  def path
    "#{FILEPATH}/../db/#{@name}"
  end

  attr_reader :db, :name
end
