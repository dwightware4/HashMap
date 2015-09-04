require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    @count +=1
    bucket = key.hash % num_buckets
    @store[bucket] << key
    if num_buckets == @count
      resize!
    end
  end

  def include?(key)
    bucket = key.hash % num_buckets
    @store[bucket].include?(key)
  end

  def remove(key)
    @count -= 1
    bucket = key.hash % num_buckets
    @store[bucket].delete(key)
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
