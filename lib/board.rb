# frozen_string_literal: true

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

  # Inserts the given counter into the given column of the board.
  # 7 columns. The counter is placed in the highest free space
  def insert(column, counter)
    if @board[column - 1]
      insert(column + 7, counter)
    else
      @board[column - 1] = counter
    end
  end

  # Return true if 4 identical counters in a row are detected anywhere. Else return false
  def won?
    # I really want this to be a constant, set at initiazation
    winning_lines = winning_rows + winning_columns + winning_diagonals
    winning_lines.each do |line|
      return true if line.all? { |pos| !@board[pos].nil? && @board[pos] == @board[line[0]] }
    end
    false
  end

  # Return true if every space in the board contains a counter. Else false
  def full?
    @board.all? { |value| value }
  end

  # Print the board to the console
  def print_board
    line_end = @columns * @rows - 1
    line_start = line_end - 6
    puts '| 1| 2| 3| 4| 5| 6| 7|'
    until line_start.negative?
      print_divider
      print_line(@board[line_start..line_end])
      line_start -= 7
      line_end -= 7
    end
    print_divider
  end

  # int -> bool
  # Returns true if the given column is full (i.e if column + 34 !nil). Else return false
  def column_full?(column)
    @board[column + 34]
  end

  private

  def winning_rows
    rows = []
    (0..3).each do |number|
      rows.push([0, 1, 2, 3].map { |win_number| win_number + number })
    end
    rows_to_return = rows.reduce([]) { |winning_rows, row| winning_rows.push(all_alligned_rows(row)) }
    rows_to_return.flatten(1)
  end

  # Kinda mislading name. Generates all lines parralel to a given row, upto the @row-offset row
  def all_alligned_rows(row, offset = 1)
    (0..@rows - offset).reduce([]) do |alligned_rows, row_height|
      alligned_rows.push(row.map { |row_number| row_number + row_height * 7 })
    end
  end

  def winning_columns
    columns = (0..@rows - 4).reduce([]) do |mem, row_number|
      mem.push([0, 7, 14, 21].map do |col_number|
                 col_number + row_number * 7
               end)
    end
    return_columns = columns.reduce([]) { |mem, column| mem.push(all_alligned_columns(column)) }
    return_columns.flatten(1)
  end

  def all_alligned_columns(column)
    (0..@columns - 1).reduce([]) do |alligned_columns, column_offset|
      alligned_columns.push(column.map { |column_number| column_number + column_offset })
    end
  end

  def winning_diagonals
    diagonals = rising_diagonals + falling_diagonals
    return_diagonals = diagonals.reduce([]) { |mem, diagonal| mem.push(all_alligned_rows(diagonal, 4)) }
    return_diagonals.flatten(1)
  end

  def rising_diagonals
    (0..@columns - 4).reduce([]) do |mem, column_number|
      mem.push([0, 8, 16, 24].map do |diagonal_number|
        diagonal_number + column_number
      end)
    end
  end

  def falling_diagonals
    (0..@columns - 4).reduce([]) do |mem, column_number|
      mem.push([21, 15, 9, 3].map do |diagonal_number|
        diagonal_number + column_number
      end)
    end
  end

  def print_divider
    puts '-----------------------'
  end

  # Takes an array an prints them to the console in the format | value |
  def print_line(line)
    line.each do |value|
      print '|'
      print value.nil? ? '  ' : value.to_s
    end
    print "|\n"
  end
end
