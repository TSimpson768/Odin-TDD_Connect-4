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

    context 'When an full column is selected, followed by an empty column' do
      before do
        allow(game_parse).to receive(:gets).and_return("1\n", "2\n")
        board_column = instance_double('Board')
        allow(board_column).to receive(:column_full?).with(1).and_return(true)
        allow(board_column).to receive(:column_full?).with(2).and_return(false)
        game_parse.instance_variable_set(:@board, board_column)
      end
      it 'Puts invalid_message once' do
        expect(game_parse).to receive(:puts).with(invalid_message).once
        game_parse.parse_input
      end

      it 'returns 2' do
        result = game_parse.parse_input
        expect(result).to eq(2)
      end
    end
  end

  describe "#update_player" do
    subject(:game_update) { described_class.new }
    context 'When current player is player1' do
      it 'sets current player to player2' do
        player1 = game_update.instance_variable_get(:@player1)
        player2 = game_update.instance_variable_get(:@player2)
        game_update.instance_variable_set(:@current_player, player1)
        game_update.update_player
        new_player = game_update.instance_variable_get(:@current_player)
        expect(new_player).to equal(player2)
      end
    end

    context 'when current player is player2' do
      it 'sets current player to player1' do
        player1 = game_update.instance_variable_get(:@player1)
        player2 = game_update.instance_variable_get(:@player2)
        game_update.instance_variable_set(:@current_player, player2)
        game_update.update_player
        new_player = game_update.instance_variable_get(:@current_player)
        expect(new_player).to equal(player1)
      end
    end
  end

  describe '#game_over' do
    context 'When board is won' do
      subject(:game_won) { described_class.new }
      before do
        won_board = instance_double("Board")
        allow(won_board).to receive(:won?).and_return(true)
        game_won.instance_variable_set(:@board, won_board)
        allow(game_won).to receive(:puts)
      end
      it 'puts current_player has won' do
        current_player = game_won.instance_variable_get(:@current_player)
        expect(game_won).to receive(:puts).with("#{current_player.name} has won!")
        game_won.game_over
      end
    end

    context 'when board is not won' do
      subject(:game_not_won) { described_class.new }
      before do
        not_won_board = instance_double("Board")
        allow(not_won_board).to receive(:won?).and_return(false)
        allow(game_not_won).to receive(:puts)
      end
      it "puts it's a tie!" do
        expect(game_not_won).to receive(:puts).with("It's a tie!")
        game_not_won.game_over
      end
    end
  end
end
