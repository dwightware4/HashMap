class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num <= @max && num >=0
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    #@num_buckets = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] << num
  end

  def remove(num)
    bucket = @store[num % num_buckets]
    bucket.delete(num)
  end

  def include?(num)
    bucket = @store[num % num_buckets]
    bucket.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    @count += 1
    bucket = @store[num % num_buckets]
    bucket << num
    if num_buckets == @count
      resize!
    end
  end

  def remove(num)
    bucket = @store[num % num_buckets]
    bucket.delete(num)
    @count -= 1
  end

  def include?(num)
    bucket = @store[num % num_buckets]
    bucket.include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {Array.new}
    new_bucket_count = num_buckets * 2

    @store.each do |old_bucket|
      old_bucket.each do |value|
        new_bucket = new_store[value % new_bucket_count]
        new_bucket << value
      end
    end

    @store = new_store

  end
end
