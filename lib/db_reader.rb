# frozen_string_literal: true

# Class for working with database
class Database
  FILEPATH = File.dirname(__FILE__)
  NAME_DB = 'db.yml'

  def read_database(name_db = NAME_DB)
    YAML.load_file("#{FILEPATH}/../db/#{name_db}")
  rescue Errno::ENOENT
    abort 'No car db found, make sure the file exists or check the path to this file.'
  end

  def write_to_database(data, name_db)
    file = File.open("#{FILEPATH}/../db/#{name_db}", 'w')
    file.write(data.to_yaml)
    file.close
  end

  def call(name_db)
    create_database(name_db) unless File.file?("#{FILEPATH}/../db/#{name_db}")
    read_database(name_db)
  end

  private

  def create_database(name_db)
    File.new("#{FILEPATH}/../db/#{name_db}", 'w')
  end
end
