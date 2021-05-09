require_relative 'board'
require 'pry'
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

  
  def parse_input
    input_regex = /^[1-7]$/
    loop do
      player_input = gets.chomp
      if input_regex.match?(player_input)
        return player_input.to_i
      end
      puts 'Invalid input, please input a value between 1-7'
    end
  end
end