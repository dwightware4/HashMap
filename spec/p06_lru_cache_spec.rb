require 'rspec'
require 'p06_lru_cache'

describe LRUCache do
  describe "#get" do
    it "should compute the return value of a function, given an input" do
      lru = LRUCache.new(3, Proc.new { |x| x ** 2 })
      expect(lru.get(2)).to eq(4)
      expect(lru.get(3)).to eq(9)
      expect(lru.get(4)).to eq(16)
      expect(lru.get(5)).to eq(25)
    end

    it "should cache values correctly" do
      lru = LRUCache.new(3, Proc.new { |x| sleep(0.05); x ** 2 })

      benchmarks = []
      3.times do |i|
        t1 = Time.now
        lru.get(i + 1)
        benchmarks << Time.now - t1
      end

      3.times do |i|
        t1 = Time.now
        lru.get(i + 1)
        expect(Time.now - t1).to be < benchmarks[i] - 0.01
      end
    end

    it "should properly eject least recently used items out of cache" do
      lru = LRUCache.new(3, Proc.new { |x| sleep(0.05); x ** 2 })
      t1 = Time.now
      lru.get(0)
      first_time = Time.now - t1

      benchmarks = []
      3.times do |i|
        t1 = Time.now
        lru.get(i + 1)
        benchmarks << Time.now - t1
      end

      t2 = Time.now
      lru.get(0)
      expect(Time.now - t2).to be < first_time + 0.01

      [0, 2, 3].each_with_index do |still_in_cache, i|
        t1 = Time.now
        lru.get(still_in_cache)
        expect(Time.now - t1).to be < benchmarks[i] - 0.01
      end
    end
  end
end
