RSpec.describe Codebreaker::Guess do
  let(:correct_guess) { Codebreaker::Guess.new(correct_input)}
  let(:correct_input) { '1234' }

  describe 'New entity of Difficulty class' do
    let(:empty_array) { [] }

      it { expect(correct_guess.user_answer).to eq(correct_input) }
      it { expect(correct_guess.instance_variable_get(:@errors)).to eq(empty_array) }
  end

  describe 'valid guess' do
    before do
      correct_guess.valid?
    end

    it "when guess valid" do
      expect(correct_guess.errors).to be_empty
    end
  end

  describe 'invalid difficulty' do
    let(:incorrect_guess) { Codebreaker::Guess.new(incorrect_input)}
    let(:incorrect_input) { '12335234' }

    before do
      incorrect_guess.valid?
    end

    it 'validation is broken for difficulty' do
      expect(incorrect_guess.errors).not_to be_empty
    end
  end
end