RSpec.describe Codebreaker::Game do
  subject(:game) { described_class.new(easy_level) }
  let(:easy_level) { Codebreaker::Difficulty.new('easy') }
  let(:medium_game) { described_class.new(medium_level) }
  let(:medium_level) { Codebreaker::Difficulty.new('medium') }
  let(:hard_game) { described_class.new(hard_level) }
  let(:hard_level) { Codebreaker::Difficulty.new('hard') }

  context 'Checking different values initialization if new game was created' do
    context 'Checking secret_code initialization' do
      let(:secret_code) { game.secret_code }

      it 'Checking if secret code has only 4 digits' do
        expect(secret_code.size).to eq(4)
      end

      it 'Checking if secret code pass validation' do
        expect(secret_code.join).to match(/^[1-6]{4}$/)
      end
    end

    context 'Checking functionality of hints assigning according to level' do
      it 'level assigned - easy' do
        expect(game.assign_hints.size).to eq(Codebreaker::Difficulty::DIFFICULTIES.dig(:easy, :hints))
      end

      it 'level assigned - medium' do
        expect(medium_game.assign_hints.size).to eq(Codebreaker::Difficulty::DIFFICULTIES.dig(:medium, :hints))
      end

      it 'level assigned - hard' do
        expect(hard_game.assign_hints.size).to eq(Codebreaker::Difficulty::DIFFICULTIES.dig(:hard, :hints))
      end
    end

    context 'Checking functionality of attempts assigning according to level' do
      it 'level assigned easy' do
        expect(game.attempts_total).to eq(Codebreaker::Difficulty::DIFFICULTIES.dig(:easy,
                                                                                                      :attempts))
      end

      it 'level assigned medium' do
        expect(medium_game.attempts_total).to eq(Codebreaker::Difficulty::DIFFICULTIES.dig(:medium,
                                                                                                        :attempts))
      end

      it 'level assigned hard' do
        expect(hard_game.attempts_total).to eq(Codebreaker::Difficulty::DIFFICULTIES.dig(:hard,
                                                                                                      :attempts))
      end
    end

    context 'Checking the functionality of hints using' do
      it 'The last digit is selected from hints array when hints method is executed' do
        hint = game.assign_hints.last
        expect(game.take_a_hint).to eq(hint)
      end

      it 'Size of hints array is changed by -1 when hint method is used' do
        expect { game.take_a_hint }.to change { game.assign_hints.size }.by(-1)
      end
    end

    context 'Viewing round result vith + and - according to secred code and user code' do
      it '+' do
        subject.instance_variable_set(:@user_code, [6, 6, 6, 6])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('+')
      end

      it '++' do
        subject.instance_variable_set(:@user_code, [1, 6, 6, 1])
        subject.instance_variable_set(:@secret_code, [6, 6, 6, 6])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('++')
      end

      it '+++' do
        subject.instance_variable_set(:@user_code, [6, 5, 4, 4])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('+++')
      end

      it '++++' do
        subject.instance_variable_set(:@user_code, [6, 6, 6, 6])
        subject.instance_variable_set(:@secret_code, [6, 6, 6, 6])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('++++')
      end

      it 'empty result' do
        subject.instance_variable_set(:@user_code, [6, 6, 6, 6])
        subject.instance_variable_set(:@secret_code, [1, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('')
      end

      it '-' do
        subject.instance_variable_set(:@user_code, [2, 6, 6, 6])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('-')
      end

      it '--' do
        subject.instance_variable_set(:@user_code, [3, 2, 2, 6])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('--')
      end

      it '---' do
        subject.instance_variable_set(:@user_code, [2, 6, 3, 4])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('---')
      end

      it '----' do
        subject.instance_variable_set(:@user_code, [4, 3, 5, 6])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('----')
      end

      it '++--' do
        subject.instance_variable_set(:@user_code, [5, 6, 4, 3])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('++--')
      end

      it '+-' do
        subject.instance_variable_set(:@user_code, [6, 4, 1, 1])
        subject.instance_variable_set(:@secret_code, [6, 5, 4, 3])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('+-')
      end

      it '+---' do
        subject.instance_variable_set(:@user_code, [1, 4, 2, 3])
        subject.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('+---')
      end

      it '++-' do
        subject.instance_variable_set(:@user_code, [1, 5, 2, 4])
        subject.instance_variable_set(:@secret_code, [1, 2, 3, 4])
        expect { subject.send(:handle_numbers) }.to change { subject.instance_variable_get(:@round_result) }.to('++-')
      end
    end

    context 'Comparing secret code with some value. True or false sholud be returned' do
      before { game.instance_variable_set(:@secret_code, [1, 2, 3, 4]) }

      it 'Result of comparing is TRUE' do
        expect(game.win?('1234')).to be_truthy
      end

      it 'result of comparing is FALSE' do
        expect(game.win?('1334')).to be_falsey
      end
    end

    context 'Checking private function check_numbers_for_correct_position. Nil is returned if position is correct' do
      before { subject.instance_variable_set(:@secret_code, [1, 2, 3, 4]) }

      it '1 digit has correct position' do
        subject.instance_variable_set(:@user_code, [2, 3, 5, 4])
        expect(subject.send(:check_numbers_for_correct_position)).to eq([1, 2, 3, nil])
      end

      it '2 digits has correct position' do
        subject.instance_variable_set(:@user_code, [1, 3, 5, 4])
        expect(subject.send(:check_numbers_for_correct_position)).to eq([nil, 2, 3, nil])
      end

      it '3 digits has correct position' do
        subject.instance_variable_set(:@user_code, [1, 2, 5, 4])
        expect(subject.send(:check_numbers_for_correct_position)).to eq([nil, nil, 3, nil])
      end

      it '4 digits has correct position' do
        subject.instance_variable_set(:@user_code, [1, 2, 3, 4])
        expect(subject.send(:check_numbers_for_correct_position)).to eq([nil, nil, nil, nil])
      end
    end
  end
end
