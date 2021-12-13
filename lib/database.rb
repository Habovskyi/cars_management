# frozen_string_literal: true

# Class for working with database
module Lib
  class Database
    attr_reader :db, :path, :name_db

    FILEPATH = File.dirname(__FILE__)
    NAME_DB = 'db.yml'

    def initialize(name_db = NAME_DB)
      @name_db = name_db
      @path = "#{FILEPATH}/../db/#{name_db}"
      create_file unless File.file?(path)
      @db = File.open(path, 'r+')
    end

    def read
      YAML.load_file(db)
    end

    def write(data)
      File.write(@path, data.to_yaml)
    end

    private

    def create_file
      File.new(path, 'w')
      puts I18n.t('message_create_database', name_db: name_db)
    end
  end
end
