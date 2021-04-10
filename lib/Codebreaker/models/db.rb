module Codebreaker
  class DB
    DB_PATH = './'
    FILENAME = 'statistics'
  
    class << self
      def load_file
        YAML.load_file(file_path) if File.exist?(file_path)
      end
  
      def file_path
        "#{DB_PATH}#{FILENAME}.yml"
      end
  
      def save_score(data)
        File.new(file_path, 'w+') unless File.exist?(file_path)
        record = load_file || []
        File.write(file_path, (record << data).to_yaml)
      end
  
      def score_data(req, game, player, difficulty)
        { name: player.name, difficulty: difficulty.level[:name], attempts_total: game.attempts_total,
          attempts_used: game.attempts_used, hints_used: game.hints_used }
      end
  
      def sort_st_records(statistics)
        levels = %w[hard medium easy]
        statistics.sort_by! do |record|
          [levels.index(record[:difficulty]), record[:attempts_used], record[:hints_used]]
        end
      end
  
      def statistics
        @statistics = load_file
      end
  
      def statistics_set(req)
        req.session[:statistics] = sort_st_records(statistics)
      end
    end
  end  
end
