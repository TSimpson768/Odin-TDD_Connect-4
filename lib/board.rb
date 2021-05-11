class Board
  def initialize
    @board = Array.new(42, nil)
  end

  def insert(column, counter)
    if @board[column - 1]
      insert(column + 7, counter)
    else
      @board[column - 1] = counter
    end
    
  end

  def won?
    
  end
end