require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map[key]
      update_link!(link)
      return link.val
    else
      value = calc!(key)
      eject! if @map.count == @max
      @store.insert(key, value)
      @map[key] = @store.last
      value
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    @prc.call(key)
  end

  def update_link!(link)
    original_last = @store.last
    @store.last.nxt = link
    link.prev.nxt = link.nxt
    link.nxt.prev = link.prev
    link.nxt = nil
    link.prev = original_last
  end

  def eject!
    @map.delete(@store.first.key)
    @store.remove(@store.first.key)
  end
end
