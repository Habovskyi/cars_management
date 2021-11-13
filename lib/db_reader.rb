# frozen_string_literal: true
class Database
  FILEPATH = File.dirname(__FILE__)
  NAME_DB = 'db.yml'

  def read_database(name_db = NAME_DB)
    YAML.safe_load(File.read("#{FILEPATH}/../db/#{name_db}"))
  rescue Errno::ENOENT
    abort 'No car db found, make sure the file exists or check the path to this file.'
  end
end
