require 'indibidual'

class Ga
  def initialize(corrects, pattern_size)
    @corrects = corrects
    @pattern_size = pattern_size
  end

  def main
    find(first_generations(10), 1)
  end

  def find(indibiduals, generation)
    sleep 0.3
    srand Time.now.usec
    indibiduals_with_score= indibiduals.each {|indibidual| selection(indibidual)}.sort{|i1, i2| i1.score != i2.score ? i2.score <=> i1.score : i2.generation <=> i1.generation }
    print_geans_with_score(indibiduals_with_score)
    if indibiduals_with_score.first.score == @corrects.size
      return indibiduals_with_score.first
    else
      find(next_generations(indibiduals_with_score, generation), generation.succ)
    end
  end

  def next_generations(indibiduals, generation)
    father, mother = indibiduals.take(2)
    twist_point = rand(@corrects.size)
    child1 = Indibidual.new(twist(father.gean, mother.gean, twist_point), generation.succ)
    child2 = Indibidual.new(twist(mother.gean, father.gean, twist_point), generation.succ)
    children = 1.times.each_with_object([]) {|_, array| array << child1.dup << child2.dup}.map{|child| child.mutation(@pattern_size) }
    indibiduals.take(8) + children
  end

  def first_generations(num)
    Array.new(num).map do
      Indibidual.new(Array.new(@corrects.size).map{ rand(@pattern_size) + 1}, 1)
    end
  end

  def twist(array1, array2, point)
    array1.zip(array2).map.with_index do |pair, index|
      index < point ? pair.first : pair.last
    end
  end

  def selection(indibidual)
    indibidual.score = score(indibidual.gean)
    indibidual.checked = indibidual.gean.zip(@corrects).map{|pair| pair[0] == pair[1] ? 'O' : 'X'}
  end

  def score(geans)
    geans.zip(@corrects).reduce(0) do |score, pair|
      pair.first == pair.last ? score.succ : score
    end
  end

  private

  def print_geans_with_score(indibiduals)
    puts '#' * 50
    indibiduals.each do |indibidual|
      puts indibidual
    end
  end
end
