class Indibidual
  attr_accessor :score, :checked
  attr_reader :gean, :generation

  def initialize(gean, generation)
    @gean = gean
    @generation = generation
  end

  def mutation(pattern_size)
    srand Time.now.usec
    point = rand(@gean.size + 2)
    unless point >= @gean.size
      @gean[point] = @gean[point] == pattern_size ? 1 : @gean[point].succ
    end
    self
  end

  def to_s
    unless @checked
      puts 1
    end
    "generation: #{@generation} score:#{@score} gean:#{@checked.zip(@gean).map{|pair| pair.join(':') }}"
  end

  def initialize_copy(original)
    @gean = original.gean.dup
    @generation = original.generation
  end
end
