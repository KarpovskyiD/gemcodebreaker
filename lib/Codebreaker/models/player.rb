module Codebreaker
  class Player < ValidatedObject
    attr_reader :name, :errors

    RANGE_OF_NAME_LENGTH = (3..20).freeze

    def initialize(name)
      super()
      @name = name
    end

    def validate
      @errors << I18n.t('errors.wrong_name') unless check_length?
    end

    private

    def check_length?
      RANGE_OF_NAME_LENGTH.include?(@name.length)
    end
  end
end
