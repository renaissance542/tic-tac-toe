# frozen_string_literal: true
# rubocop:disable Metrics/BlockLength

require_relative '../lib/gameboard'

describe GameBoard do
  # initialize does not need to be tested
  subject(:board) { described_class.new }

  describe '#move' do
    before do
      
    end

    context 'when input is invalid' do
      it 'returns false 'do
        expect(board.move(12)).to be false
      end
    end

    context 'when square is already X or O' do
      before do
        board.instance_variable_set(:@board, [1, 2, 'X', 4, 5, 6, 7, 8, 9])
      end

      it 'returns false' do
        expect(board.move(3)).to be false
      end
    end

    context 'when input is valid' do
      it 'returns true' do
        expect(board.move(5)).to be true
      end
    end
  end

  describe '#reset' do
    it 'returns "X"' do
      expect(board.reset).to eq('X')
    end
  end

  describe '#game_over?' do
    context 'when 9 turns have passed' do
      it 'is true' do
        board.instance_variable_set(:@movelist, [1, 2, 3, 4, 5, 6, 7, 8, 9])
        expect(board.game_over?).to be true
      end
    end

    context 'returns true for winning patterns' do
      it ' XXX across top' do
        board.instance_variable_set(:@board, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
        expect(board.game_over?).to be true
      end

      it ' OOO across mid' do
        board.instance_variable_set(:@board, [1, 2, 3, 'O', 'O', 'O', 7, 8, 9])
        expect(board.game_over?).to be true
      end
      it ' XXX in middle column' do
        board.instance_variable_set(:@board, [1, 'X', 3, 4, 'X', 6, 7, 'X', 9])
        expect(board.game_over?).to be true
      end

      it ' XXX diagonally' do
        board.instance_variable_set(:@board, ['X', 2, 3, 4, 'X', 6, 7, 8, 'X'])
        expect(board.game_over?).to be true
      end

      it ' OOO diagonally' do
        board.instance_variable_set(:@board, ['O', 2, 3, 4, 'O', 6, 7, 8, 'O'])
        expect(board.game_over?).to be true
      end
    end
  end


end