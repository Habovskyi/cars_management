class Database
  FILEPATH = File.dirname(__FILE__).freeze

  def read_database
    begin
      YAML.load(File.read(FILEPATH + '/../db/db.yml'))
    rescue Errno::ENOENT
      abort 'No car db found, make sure the file exists or check the path to this file.'
    end
  end
end
