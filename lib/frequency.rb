class Frequency

  attr_reader :freq

  def initialize
    @freq = Hash.new(0)
    @total = 0
  end

  def add(char)
    @freq[char] +=  1
    @total += 1
  end

  def highest_freq
    key, = @freq.max { |f1, f2| f1[1] <=> f2[1]}
    key
  end

  def random
    n = rand(@total)
    count = 0
    key, = @freq.find do |ch,freq|
      count += freq
      count > n
    end
    key
  end

end