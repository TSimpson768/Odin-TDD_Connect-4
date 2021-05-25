
# Board of a connect 4 game. @board represents the board
# in the order
# 35, 36, 37, 38, 39, 40, 41
# 28, 29, 30, 31, 32, 33, 34
# 21, 22, 23, 24, 25, 26, 27
# 14, 15, 16, 17, 18, 19, 20
#  7,  8,  9, 10, 11, 12, 13
#  0,  1,  2,  3,  4,  5,  6
class Board
  COUNTERS_TO_WIN = 4
  def initialize(columns = 7, rows = 6)
    @columns = columns
    @rows = rows
    num_spaces = columns * rows
    @board = Array.new(num_spaces, nil)
  end

  def insert(column, counter)
    if @board[column - 1]
      insert(column + 7, counter)
    else
      @board[column - 1] = counter
    end
    
  end

  def won?
    winning_lines = winning_rows # I really want this to be a constant, set at initiazation
    winning_lines.each do |line|
      return true if line.all? { |pos| !@board[pos].nil? && @board[pos] == @board[line[0]] }
    end
    false
  end

  private

  def winning_rows
    rows = []
    (0..3).each do | number |
      rows.push([0,1,2,3].map {|win_number| win_number + number})
    end
    rows_to_return = rows.reduce([]) { | winning_rows, row | winning_rows.push(all_alligned_rows(row))}
    rows_to_return.flatten(1)
  end

  def all_alligned_rows(row)
    (0..@rows-1).reduce([]) do |alligned_rows, row_height |
      alligned_rows.push(row.map {|row_number| row_number + row_height * 7})
    end
  end

  def winning_columns
    
  end

  def winning_diagonals
    
  end
end