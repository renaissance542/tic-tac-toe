# frozen_string_literal: true
# rubocop:disable Metrics/AbcSize

require 'pry-byebug'
require_relative 'gameboard'

# manages I/O, players, and the board
class Game
  def initialize
    @board = GameBoard.new
  end

  def play
    load_players
    until @board.game_over?
      print_board
      puts "Enter a number where to play '#{@board.next_move}'"
      move = gets.chomp.to_i
      puts 'Invalid move.\n' unless @board.move(move)
    end

    print_board
    winner = @board.movelist.length.even? ? @player2 : @player1
    puts "Game over! #{winner} Won!"
  end

  private

  def load_players
    puts 'Enter player 1 name:'
    @player1 = gets.chomp
    puts 'Enter player 2 name:'
    @player2 = gets.chomp
  end

  def print_board
    puts <<~BOARD

      #{@board.board[0]} #{@board.board[1]} #{@board.board[2]}
      #{@board.board[3]} #{@board.board[4]} #{@board.board[5]}
      #{@board.board[6]} #{@board.board[7]} #{@board.board[8]}
    BOARD
  end
end