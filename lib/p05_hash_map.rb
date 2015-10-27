require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store, @count = Array.new(num_buckets) { LinkedList.new }, 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    @count += 1
    @store[bucket(key)].insert(key, val)
    if num_buckets == @count
      resize!
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @count -= 1
    @store[bucket(key)].remove(key)
  end

  def each(&blk)
    @store.each do |bucket|
      bucket.each {blk}
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) {LinkedList.new}
    new_bucket_count = num_buckets * 2

    @store.each do |old_bucket|
      old_bucket.each do |link|
        new_bucket = link.key.hash % new_bucket_count
        new_store[new_bucket].insert(link.key, link.val)
      end
    end

    @store = new_store
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
