# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require 'pry'
class Game
  def initialize(board = Board.new)
    @board = board
    @player1 = Player.new('player 1', '🔴')
    @player2 = Player.new('player 2', '🔵')
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
      @board.print_board
      input = parse_input
      @board.insert(input, @current_player.counter)
      break if @board.won?

      update_player
    end
    game_over
  end

  def parse_input
    input_regex = /^[1-7]$/
    loop do
      puts 'Choose a column to place a counter in [1-7]'
      player_input = gets.chomp
      return player_input.to_i if input_regex.match?(player_input) && !@board.column_full?(player_input.to_i)

      puts 'Invalid input, please input a value between 1-7'
    end
  end

  def update_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end

  def game_over
    puts 'Game over'
    @board.print_board
    if @board.won?
      puts "#{@current_player.name} has won!"
    else
      puts "It's a tie!"
    end
  end
end
