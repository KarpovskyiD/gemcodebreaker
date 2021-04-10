RSpec.describe Codebreaker::DB do
  subject(:db) { Codebreaker::DB }
  let(:player) {Codebreaker::Player.new('Name')}
  let(:difficulty) {Codebreaker::Difficulty.new('easy')}
  let(:game) {Codebreaker::Game.new(difficulty)}
  let(:db_name) {'statistics'}

  context 'checking the creating the db file' do

    before do
      File.delete(db.file_path(db_name)) if File.exist?(db.file_path(db_name))
    end

    it 'Checking the file creation' do
      result = { name: player.name, difficulty: difficulty.level[:name], attempts_total: game.attempts_total,
        attempts_used: game.attempts_used, hints_used: game.hints_used }
      db.save_score(result)
      expect(File).to exist(db.file_path(db_name))
    end
  end

  context 'checking the creating the db file' do

    after do
      File.delete(db.file_path(db_name)) if File.exist?(db.file_path(db_name))
    end

    it 'Veryfying the data in the file' do
      file = File.read(db.file_path(db_name))
      expect(file).to match(player.name)
    end
  end
end
