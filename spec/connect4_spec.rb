require 'connect4'
require 'player'

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
  
end