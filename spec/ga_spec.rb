require 'rspec'
require 'ga'

describe 'Ga' do
  describe 'score' do
    let(:ga) { Ga.new([2, 4, 4, 3, 1, 3, 1, 4, 3, 3], 4) }

    subject { ga.score(answer) }

    context 'perfect' do
      let(:answer) { [2, 4, 4, 3, 1, 3, 1, 4, 3, 3] }

      it { is_expected.to eq 10 }
    end

    context '8 correct' do
      let(:answer) { [2, 4, 4, 2, 1, 3, 4, 4, 3, 3] }

      it { is_expected.to eq 8 }
    end

    context '0 correct' do
      let(:answer) { [3, 1, 1, 4, 2, 4, 1, 1, 4, 4] }

      it { is_expected.to eq 1 }
    end
  end

  describe 'twist' do
    let(:ga) { Ga.new([2, 4, 4, 3, 1, 3, 1, 4, 3, 3], 4) }
    let(:array1) {[0, 1, 2, 3, 4, 5, 6, 7]}
    let(:array2) {[7, 6, 5, 4, 3, 2, 1, 0]}

    subject { ga.twist([0, 1, 2, 3, 4, 5, 6, 7], [7, 6, 5, 4, 3, 2, 1, 0], point) }

    context 'Point is 0' do
      let(:point) { 0 }

      it { is_expected.to eq array2}
    end

    context 'Point is 3' do
      let(:point) { 3 }

      it { is_expected.to eq [0, 1, 2, 4, 3, 2, 1, 0]}
    end

    context 'Point is 8' do
      let(:point) { 8 }

      it { is_expected.to eq array1}
    end
  end

  describe 'first_generation' do
    let(:ga) { Ga.new([2, 4, 4, 3, 1, 3, 1, 4, 3, 3], 4) }

    subject { ga.first_generations(10) }

    it { expect(subject.size).to eq 10}
    it { expect(subject.first.gean - [1, 2, 3, 4]).to be_empty}
  end

  describe 'next_generations' do
    let(:ga) { Ga.new([2, 4, 4, 3, 1, 3, 1, 4, 3, 3], 4) }
    let(:geans) {
      [
        [2, 4, 4, 3, 1, 3, 1, 4, 2, 3],
        [2, 4, 4, 3, 1, 3, 1, 4, 3, 2],
        [2, 4, 4, 3, 1, 3, 1, 4, 2, 2],
        [2, 4, 4, 3, 1, 3, 1, 2, 2, 2],
        [2, 4, 4, 3, 1, 3, 2, 2, 2, 2]
      ]
    }

    subject { ga.next_generations(geans) }

    it { expect(subject.size).to eq 5}
    it { expect(subject[0]).to eq geans[0]}
    it { expect(subject[1]).to eq geans[1]}
    it { expect(subject[2]).to eq geans[2]}
    it { expect(subject[3]).to_not eq geans[3]}
    it { expect(subject[4]).to_not eq geans[4]}
  end

  describe 'main' do
    let(:ga) { Ga.new([2, 2, 1, 3, 1, 3, 1, 2, 3, 3], 3) }

    subject { ga.main }

    it { expect(subject.gean).to eq [2, 2, 1, 3, 1, 3, 1, 2, 3, 3] }
  end
end
