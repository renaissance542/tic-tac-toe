# frozen_string_literal: true
# rubocop:disable Metrics/BlockLength

require_relative '../lib/game'
require_relative '../lib/gameboard'

describe Game do
  subject(:game) { described_class.new }
  let(:board1) { instance_double(GameBoard) }

  describe '#play' do
    context 'When #gameover? is true ' do
      before do
        allow(game).to receive(:load_players)
        allow(board1).to receive(:game_over?).and_return(true)
        allow(game).to receive(:print_board)
        allow(board1).to receive_message_chain(:movelist, :length, :even?)
        allow(game).to receive(:puts)
        game.instance_variable_set(:@board, board1)
      end

      it 'does not request #gets input' do
        expect(game).not_to receive(:gets)
        game.play
      end

      it 'checks the board movelist for the winner' do
        expect(board1).to receive_message_chain(:movelist, :length, :even?)
        game.play
      end
    end

    context 'When game_over? is false then true' do
      before do
        game.instance_variable_set(:@board, board1)
        allow(game).to receive(:load_players)
        allow(board1).to receive(:game_over?).and_return(false, true)
        allow(game).to receive(:print_board)
        allow(board1).to receive_message_chain(:movelist, :length, :even?)
        allow(board1).to receive(:next_move)
        allow(board1).to receive(:move)
        allow(game).to receive_message_chain(:gets, :chomp, :to_i)
        allow(game).to receive(:puts)
      end

      it 'gets a new move' do
        expect(game).to receive(:gets).once
        game.play
      end
    end

  end

  describe '#load_players' do
    # this would normally be untested as a private method
    # it is called in #play

    before do
      allow(game).to receive(:puts)
      allow(game).to receive_message_chain(:gets, :chomp, :to_i)
    end

    it 'calls :gets twice' do
      expect(game).to receive(:gets).twice
      game.send(:load_players)
    end
  end
end