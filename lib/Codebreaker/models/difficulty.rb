module Codebreaker
  class Difficulty < ValidatedObject
    attr_reader :name, :errors, :level

    DIFFICULTIES = {
      easy: { name: 'easy', attempts: 15, hints: 2 },
      medium: { name: 'medium', attempts: 10, hints: 1 },
      hard: { name: 'hard', attempts: 5, hints: 1 }
    }.freeze

    def initialize(level)
      super()
      @level = DIFFICULTIES[level.to_sym]
    end

    def validate
      @errors << I18n.t('errors.wrong_difficulty') if difficulty_nil?
    end

    private

    def difficulty_nil?
      @level.nil?
    end
  end
end
