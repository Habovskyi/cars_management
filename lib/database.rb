# frozen_string_literal: true

# Class for working with database
class Database
  FILEPATH = File.dirname(__FILE__)
  NAME_DB = 'db.yml'

  def initialize(name_db = NAME_DB)
    @path = "#{FILEPATH}/../db/#{name_db}"
    create_file unless File.file?(@path)
    @db = File.open(@path, 'r+')
  end

  def read
    YAML.load_file(@db)
  end

  def write(data)
    @db.write(data.to_yaml)
    @db.close
  end

  private

  def create_file
    File.new(@path, 'w')
  end

  attr_reader :db, :path
end
