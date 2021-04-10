module Codebreaker
  class DB
    FOLDER_PATH = './'.freeze
    DB_NAME = 'statistics'.freeze
    class << self
      def load_file(filename)
        YAML.load_file(file_path(filename)) if File.exist?(file_path(filename))
      end

      def file_path(filename)
        "#{FOLDER_PATH}#{filename}.yml"
      end

      def save_score(data)
        current_file_path = file_path(:statistics)
        File.new(current_file_path, 'w+') unless File.exist?(current_file_path)
        record = load_file(DB_NAME) || []
        File.write(current_file_path, (record << data).to_yaml)
      end
    end
  end
end
