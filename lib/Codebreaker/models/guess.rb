module Codebreaker
  class Guess < ValidatedObject
    attr_reader :user_answer, :errors

    def initialize(user_answer)
      super()
      @user_answer = user_answer
    end

    def validate
      @errors << I18n.t('errors.wrong_user_answer') unless valid_user_answer?
    end

    private

    def valid_user_answer?
      @user_answer =~ /^[1-6]{4}$/
    end
  end
end
