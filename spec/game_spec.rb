require "../lib/game"

describe Game do
  describe "#play" do
    
  end

  describe "#parse_input" do
    subject(:game_parse) { described_class.new }
    invalid_message = 'Invalid input, please input a value between 1-7'
    before do
      allow(game_parse).to receive(:puts)
    end
    context "When player inputs a number between 1-7" do
      before do
        allow(game_parse).to receive(:gets).and_return("5\n")
      end
      it 'returns the input' do
        result = game_parse.parse_input
        expect(result).to eq(5)
      end

      it 'Does not puts invalid input' do
        expect(game_parse).not_to receive(:puts).with(invalid_message)
        game_parse.parse_input
      end
    end

    context 'When an invalid input is entered, followed by 4' do
      before do
        allow(game_parse).to receive(:gets).and_return("314159\n", "4\n")
      end
      it 'Puts invalid_message once' do
        expect(game_parse).to receive(:puts).with(invalid_message).once
        game_parse.parse_input
      end
      it 'returns 4' do
        result = game_parse.parse_input
        expect(result).to eq(4)
      end
    end
  end
end
