RSpec.describe Codebreaker::Player do
  subject(:player) { described_class.new(valid_name) }
  let(:valid_name) { 'Username'}

  describe 'Creating new instance of Player' do
    let(:empty_array) { [] }

    it { expect(player.name).to eq(valid_name) }
    it { expect(player.instance_variable_get(:@errors)).to eq(empty_array) }
  end

  describe 'invalid player name' do
    let(:invalid_name) { '1' }
    let(:errors_array) do
      [I18n.t('errors.wrong_name')]
    end

    before do
      player.instance_variable_set(:@name, invalid_name)
      player.validate
    end

    it 'when #validate is false' do
      expect(player.errors).to eq(errors_array)
    end

    it 'when #valid? is false' do
      expect(player.valid?).to eq(false)
    end
  end

  describe 'valid player name' do
    before { player.validate }

    it 'errors are empty' do
      expect(player.errors).to be_empty
    end

    it 'validation is successfull' do
      expect(player.valid?).to eq(true)
    end
  end
end     