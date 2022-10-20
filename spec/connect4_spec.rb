require 'connect4'
require 'player'
require 'colorize'

describe Connect4 do

  let(:p1) { Player.new(1, name: 'Dyllan') }
  let(:p2) { Player.new(2, name: 'John') }
  
  let(:positions) do
    [
      [1,0,0,0,0,0],
      [0,1,0,1,1,1],
      [0,0,1,0,0,0],
      [1,1,1,1,0,0],
      [0,0,1,1,0,0],
      [0,1,0,1,0,0],
      [1,0,0,1,0,0]    
    ]
  end

  subject do
    described_class.new(p1, p2)
  end

  before do
    subject.columns = positions
  end

  describe '#up' do
    it nil, :aggregate_failures do
      expect(subject.up(3,0,1)).to eq(true)
      expect(subject.up(3,0,2)).to eq(false)
      expect(subject.up(3,1,1)).to eq(false)
    end
  end

  describe '#up_right' do
    it nil, :aggregate_failures do
      expect(subject.up_right(0,0,1)).to eq(true)
      expect(subject.up_right(0,0,2)).to eq(false)
      expect(subject.up_right(2,0,1)).to eq(false)
    end
  end

  describe '#right' do
    it nil, :aggregate_failures do
      expect(subject.right(3,3,1)).to eq(true)
      expect(subject.right(3,3,2)).to eq(false)
      expect(subject.right(2,3,1)).to eq(false)
    end
  end

  describe '#down_right' do
    it nil, :aggregate_failures do
      expect(subject.down_right(3,3,1)).to eq(true)
      expect(subject.down_right(3,3,2)).to eq(false)
      expect(subject.down_right(4,3,1)).to eq(false)
    end
  end

  describe '#check_fields' do
    it nil, :aggregate_failures do
      expect(subject.check_fields(3,3,1).any?).to eq(true)
      expect(subject.check_fields(3,3,2).any?).to eq(false)
      expect(subject.check_fields(0,0,1).any?).to eq(true)
      expect(subject.check_fields(0,0,2).any?).to eq(false)
    end
  end

  describe '#player_wins' do
    it nil, :aggregate_failures do
      expect(subject.player_wins?(p1)).to eq(true)
      expect(subject.player_wins?(p2)).to eq(false)
    end
  end

  describe '#stalemate' do
    context 'when there are still pieces to play' do
      it 'is not a stalemate' do
        expect(subject.stalemate?).to eq(false)
      end
    end

    context 'when there are no more pieces to play' do
      let(:positions) do
        [
          [1,1,2,2,1,1],
          [2,2,1,2,2,2],
          [2,2,2,1,2,2],
          [1,2,1,1,2,1],
          [1,1,2,2,1,1],
          [2,2,1,1,2,2],
          [1,1,2,2,1,1]    
        ]
      end
      
      it 'should be a stalemate' do
        expect(subject.stalemate?).to eq(true)
      end
    end
  end

  describe '#play' do
    before do
      allow_any_instance_of(Connect4).to receive(:prompt).and_return('1')
    end

    context 'player 1 wins' do
      before do
        allow_any_instance_of(Connect4).to receive(:player_wins?).and_return(true)
      end

      it 'updates player 1 score' do
        expect { subject.play }.to change { p1.score }.by(1)
      end
    end

    context 'player 2 wins' do
      before do
        allow_any_instance_of(Connect4).to receive(:player_wins?).and_return(false, true)
      end

      it 'updates player 2 score' do
        expect { subject.play }.to change { p2.score }.by(1)
      end
    end
  end
  
end