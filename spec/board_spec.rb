require '../lib/board'
describe Board do
  counter_red = '🔴'
  counter_blue = '🔵'
  describe '#insert' do
    context 'When board is empty' do
      subject(:empty_board) { described_class.new }
      it 'inserts counter into @board[input -1]' do
        column = 7
        counter = '🔴'
        empty_board.insert(column, counter)
        updated_board = empty_board.instance_variable_get(:@board)
        expect(updated_board[column - 1]).to eq(counter)
      end
    end
    context 'When inserting into a column with 1 counter' do
      subject(:part_filled_board) { described_class.new }
      input = 5

      board = Array.new(42, nil)
      board[input - 1] = counter_blue
      expected_board = board.clone
      updated_place = input - 1 + 7
      expected_board[updated_place] = counter_red

      before do
        part_filled_board.instance_variable_set(:@board, board)
      end
      xit 'inserts counter into @board[input - 1 + 7]' do
        part_filled_board.insert(input, counter_red)
        updated_board = part_filled_board.instance_variable_get(:@board)
        expect(updated_board[updated_place]).to eq(counter_red)
      end

      it 'does not change the rest of the board' do
        part_filled_board.insert(input, counter_red)
        updated_board = part_filled_board.instance_variable_get(:@board)
        expect(updated_board).to eq(expected_board)
      end
    end
  end

  describe 'won?' do
    context 'when board is empty' do
      subject(:empty_board) {described_class.new}
      it 'returns false' do
        expect(empty_board).not_to be_won
      end
    end
    context 'When there is 4 same coloured counters in a row' do
      subject(:board_row) {described_class.new}
      before do
        board = Array.new(42, nil)
        board[0] = counter_blue
        board[1]= counter_blue
        board[2] = counter_blue
        board[3] = counter_blue
        board_row.instance_variable_set(:@board, board)
      end
      it 'returns true' do
        expect(board_row).to be_won
      end
    end
  
    context 'when there is 4 same coloured counters in a column' do
      subject(:board_column) {described_class.new}
      before do
        board = Array.new(42, nil)
        board[8] = counter_red
        board[15] = counter_red
        board[22] = counter_red
        board[29] = counter_red
        board[1] = counter_blue
        board[0] = counter_blue
        board[7] = counter_blue
        board[6] = counter_blue
        board_column.instance_variable_set(:@board, board)
      end
      it 'returns true' do
        expect(board_column).to be_won
      end
    end
    context 'When there is 4 same coloured counters on a diagonal' do
      xit 'returns true' do
        
      end  
    end
    context 'When a game is in progress with no winning lines' do
      xit 'returns false' do
        
      end
    end
    context 'When a board is full with no wins' do
      xit 'returns false' do
        
      end
    end
  end

end