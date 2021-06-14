# frozen_string_literal: true

require 'pry'

# updates and returns board state
class GameBoard
  attr_reader :next_move, :game_over, :board, :movelist

  def initialize
    @movelist = []
    @game_over = false
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @next_move = 'X'
  end

  def move(int)
    return false if
      @game_over ||
      !int.between?(1, 9) ||
      !@board[int-1].is_a?(Integer)

    @movelist.push(int)
    @board[int - 1] = @next_move
    @next_move = @next_move == 'X' ? 'O' : 'X'
    check_win
    true
  end

  def reset
    @movelist = []
    @game_over = false
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @next_move = 'X'
  end

  private

  def check_win
    @game_over = true if
    #check 3 in a row
    (@board[0..2].all? @board[0]) ||
    (@board[3..5].all? @board[3]) ||
    (@board[6..8].all? @board[6]) ||
    #check 3 in columns
    ([@board[0], @board[3], @board[6]].all? @board[0]) ||
    ([@board[1], @board[4], @board[7]].all? @board[1]) ||
    ([@board[2], @board[5], @board[8]].all? @board[2]) ||
    #check diagonals
    ([@board[0], @board[4], @board[8]].all? @board[0]) ||
    ([@board[6], @board[4], @board[2]].all? @board[6]) 
  end
end

# manages I/O, players, and the board
class Game
  def initialize
    @board = GameBoard.new
  end

  def play
    load_players
    until @board.game_over
      print_board
      puts "Enter a number where to play '#{@board.next_move}'"
      move = gets.chomp.to_i
      puts 'Invalid move.\n' unless @board.move(move)
    end

    puts 'Game over! Somebody Won!'
  end

  private

  def load_players
    puts 'Enter player 1 name:'
    @player1 = gets.chomp
    puts 'Enter player 2 name:'
    @player2 = gets.chomp
  end

  def print_board
    puts ''
    puts "#{@board.board[0]} #{@board.board[1]} #{@board.board[2]}"
    puts "#{@board.board[3]} #{@board.board[4]} #{@board.board[5]}"
    puts "#{@board.board[6]} #{@board.board[7]} #{@board.board[8]}"
  end
end

round1 = Game.new
round1.play

