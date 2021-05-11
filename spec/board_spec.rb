require '../lib/board'
describe Board do
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
      counter_red = '🔴'
      counter_blue = '🔵'
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
    
  end
end