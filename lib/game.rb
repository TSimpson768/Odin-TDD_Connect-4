class Game
  def initialize(board = Board.new)
    @board = board
  end

  # Main game loop. This is a looping script that
  # puts Question for input
  # Get and validate input is valid. 
  # Update the board.
  # Check if the game has been won. If so, break
  # Update the current player.
  def play
    loop do
      input = parse_input
      @board.insert(input)
      break if @board.won?

      update_player
    end
  end
end