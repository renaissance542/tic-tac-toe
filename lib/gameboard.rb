# frozen_string_literal: true

require 'pry-byebug'

# updates and returns board state
class GameBoard
  attr_reader :next_move, :board, :movelist

  def initialize
    @movelist = []
    @board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @next_move = 'X'
  end

  def move(int)
    return false if
      !int.between?(1, 9) || # invalid input
      !@board[int-1].is_a?(Integer) # already marked X or O

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

  # board is full or game is won
  def game_over?
    @movelist.length == 9 || check_win
  end

  private

  # checks board for 3 in a row win condition
  def check_win
    check_horizontal_win ||
      check_verticle_win ||
      check_diagonal_win
  end

  def check_horizontal_win
    (@board[0..2].all? @board[0]) ||
      (@board[3..5].all? @board[3]) ||
      (@board[6..8].all? @board[6])
  end

  # rubocop:disable Metrics/AbcSize
  def check_verticle_win
    ([@board[0], @board[3], @board[6]].all? @board[0]) ||
      ([@board[1], @board[4], @board[7]].all? @board[1]) ||
      ([@board[2], @board[5], @board[8]].all? @board[2])
  end

  def check_diagonal_win
    ([@board[0], @board[4], @board[8]].all? @board[0]) ||
      ([@board[6], @board[4], @board[2]].all? @board[6])
  end
end