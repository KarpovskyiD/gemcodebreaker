module Codebreaker
  class Game < ValidatedObject
    attr_reader :hints_total, :attempts_total, :attempts_left, :secret_code, :hints_left

    RANGE_OF_DIGITS = (1..6).freeze
    SECRET_CODE_LENGTH = 4
    GUESSED_SYMBOL = '+'.freeze
    NOT_GUESSED_SYMBOL = '-'.freeze

    def initialize(difficulty)
      super()
      @secret_code = generate_code
      @attempts_total = @attempts_left = difficulty.level[:attempts]
      @hints_total = @hints_left = difficulty.level[:hints]
      @active_game = true
    end

    def guess(user_value)
      @user_code = user_value.chars.map(&:to_i)
      handle_numbers
      @attempts_left -= 1
      @round_result.empty? ? I18n.t('no_matches') : @round_result
    end

    def handle_numbers
      uncatched_numbers = check_numbers_for_correct_position
      @round_result = GUESSED_SYMBOL * uncatched_numbers.select(&:nil?).size
      @user_code.compact.map do |number|
        next unless uncatched_numbers.compact.include?(number)

        @round_result += NOT_GUESSED_SYMBOL
        uncatched_numbers[uncatched_numbers.index(number)] = nil
      end
    end

    def assign_hints
      @hints ||= secret_code.uniq.shuffle.take(@hints_total)
    end

    def take_a_hint
      assign_hints
      @hints_left -= 1
      @hints.pop
    end

    def win?(guess)
      @secret_code.join == guess
    end

    def lose?
      @attempts_left.zero?
    end

    def hints_used
      @hints_total - @hints_left
    end

    def attempts_used
      @attempts_total - @attempts_left + 1
    end

    private

    def generate_code
      Array.new(SECRET_CODE_LENGTH) { rand(RANGE_OF_DIGITS) }
    end

    def check_numbers_for_correct_position
      secret_code.map.with_index do |element, index|
        next element unless element == @user_code[index]

        @user_code[index] = nil
      end
    end
  end
end
