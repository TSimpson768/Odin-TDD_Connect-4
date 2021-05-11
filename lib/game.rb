require_relative 'board'
require_relative 'player'
require 'pry'
class Game
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new
    @player2 = Player.new
    @current_player = @player1
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
      @board.insert(input, @current_player.counter)
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

  def update_player
    if @current_player == @player1
      @current_player = @player2
    else
      @current_player = @player1
    end
    
  end
end