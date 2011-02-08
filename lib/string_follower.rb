require 'frequency'

class StringFollower
  def initialize
    @string_table = {}
    @prefix = []
  end

  def eat_dir(dir)
    
  end

  def feed(str, ch = nil)
    feed_item(str, ch) if ch
    feed_string(str) unless ch
  end

  def most_likely(str)
    freq = @string_table[str]
    if (freq)
      freq.highest_freq
    else
      nil
    end
  end

  def random(str)
    freq = @string_table[str]
    if (freq)
      freq.random
    else
      " "
    end
  end

  private

  def feed_item(str, ch)
    if not @string_table.has_key?(str)
      @string_table[str] = Frequency.new
    end
    @string_table[str].add(ch)
  end

  def feed_string(str)
    str.each_char do |ch|
      if @prefix.length >= 4
        feed_item(@prefix.join, ch)
        @prefix.push(ch).shift
      else
        @prefix.push ch
      end
    end
  end

end
