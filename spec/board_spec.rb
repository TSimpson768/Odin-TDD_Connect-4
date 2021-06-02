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
      # xit 'inserts counter into @board[input - 1 + 7]' do
      #   part_filled_board.insert(input, counter_red)
      #   updated_board = part_filled_board.instance_variable_get(:@board)
      #   expect(updated_board[updated_place]).to eq(counter_red)
      # end

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
    context 'When there is 4 same coloured counters on a / diagonal' do
      subject(:board_rising_diagonal) { described_class.new }
      before do
        board = Array.new(42, nil)
        board[2] = counter_blue
        board[10] = counter_blue
        board[18] = counter_blue
        board[26] = counter_blue
        board[3] = counter_red
        board[4] = counter_red
        board[11] = counter_red
        board[5] = counter_red
        board[12] = counter_red
        board[19] = counter_red
        board[6] = counter_blue
        board_rising_diagonal.instance_variable_set(:@board, board)
      end
      it 'returns true' do
        expect(board_rising_diagonal).to be_won  
      end  
    end
    context 'When there is 4 same coloured counters on a \ diagonal' do
      subject(:board_falling_diagonal) { described_class.new }
      before do
        board = Array.new(42, nil)
        board[6] = counter_blue
        board[12] = counter_blue
        board[18] = counter_blue
        board[24] = counter_blue
        board[5] = counter_red
        board[4] = counter_red
        board[11] = counter_red
        board[3] = counter_red
        board[10] = counter_red
        board[17] = counter_red
        board_falling_diagonal.instance_variable_set(:@board, board)
      end
      it 'returns true' do
        expect(board_falling_diagonal).to be_won
      end  
    end
    context 'When a game is in progress with no winning lines' do
      subject(:board_in_progress) { described_class.new }
      before do
        board = Array.new(42, nil)
        board[0] = counter_red
        board[1] = counter_red
        board[5] = counter_red
        board[6] = counter_red
        board[2] = counter_blue
        board[3] = counter_blue
        board[4] = counter_blue
        board[7] = counter_blue
        board_in_progress.instance_variable_set(:@board, board)
      end
      it 'returns false' do
       expect(board_in_progress).not_to be_won  
      end
    end
    context 'When a board is full with no wins' do
      subject(:board_over) { described_class.new }
      before do
        board = [ counter_blue, counter_blue, counter_red ,counter_red , counter_red , counter_blue ,counter_blue,
                  counter_blue, counter_blue, counter_red ,counter_red , counter_red , counter_blue, counter_blue,
                  counter_red, counter_blue , counter_blue , counter_blue, counter_red, counter_red, counter_red,
                  counter_blue, counter_red, counter_blue, counter_red, counter_blue, counter_blue, counter_blue,
                  counter_blue, counter_red, counter_blue, counter_red, counter_blue, counter_red, counter_blue, 
                  counter_blue, counter_red, counter_red, counter_red, counter_blue, counter_red, counter_blue]
        board_over.instance_variable_set(:@board, board)
      end
      it 'returns false' do
        expect(board_over).not_to be_won
      end
    end
  end
  describe '#full?' do
    context 'When board is not full' do
      subject(:board_not_full) { described_class.new }
      before do
        board = Array.new(42, nil)
        board[0] = counter_red
        board[1] = counter_red
        board[5] = counter_red
        board[6] = counter_red
        board[2] = counter_blue
        board[3] = counter_blue
        board[4] = counter_blue
        board[7] = counter_blue
        board_not_full.instance_variable_set(:@board, board)
      end
      it 'returns false' do
        expect(board_not_full).not_to be_full
      end
    end

    context 'when board is full' do
      subject(:board_full) { described_class.new }
      before do
        board = [ counter_blue, counter_blue, counter_red ,counter_red , counter_red , counter_blue ,counter_blue,
                  counter_blue, counter_blue, counter_red ,counter_red , counter_red , counter_blue, counter_blue,
                  counter_red, counter_blue , counter_blue , counter_blue, counter_red, counter_red, counter_red,
                  counter_blue, counter_red, counter_blue, counter_red, counter_blue, counter_blue, counter_blue,
                  counter_blue, counter_red, counter_blue, counter_red, counter_blue, counter_red, counter_blue, 
                  counter_blue, counter_red, counter_red, counter_red, counter_blue, counter_red, counter_blue]
        board_full.instance_variable_set(:@board, board)
      end
      it 'returns true' do
        expect(board_full).to be_full  
      end
    end
  end
  describe '#print_board' do
    subject(:board_print) {described_class.new}
    before do
      board = Array.new(42, nil)
      board[0] = counter_red
      board[1] = counter_red
      board[5] = counter_red
      board[6] = counter_red
      board[2] = counter_blue
      board[3] = counter_blue
      board[4] = counter_blue
      board[7] = counter_blue
      board_print.instance_variable_set(:@board, board)
      allow(board_print).to receive(:print_divider)
      allow(board_print).to receive(:print_line)
    end

    it 'Calls print line for every row (exactly 6 times)' do
      num_rows = board_print.instance_variable_get(:@rows)
      expect(board_print).to receive(:print_line).exactly(num_rows).times
      board_print.print_board
    end
  end
  describe '#column_full' do
    subject(:board_column) { described_class.new }
    before do
      board = Array.new(42, nil)
      board[0] = board[7] = board[14] = board[28] = board[35] = counter_red
      board[1] = board[21] = board[8] = board[15] = board[2] = counter_blue
      board_column.instance_variable_set(:@board, board)
    end
    it 'returns true for a full column' do
      expect(board_column).to be_column_full(1)
    end

    it 'returns false for a partially full column' do
      expect(board_column).not_to be_column_full(2)
    end

    it 'returns false for an empty column' do
      expect(board_column).not_to be_column_full(4)
    end
  end
end