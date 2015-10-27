require 'byebug'

class Link
  attr_accessor :key, :val, :nxt, :prev

  def initialize(key = nil, val = nil, nxt = nil, prev = nil)
    @key, @val, @nxt, @prev = key, val, nxt, prev
  end

  def to_s
    "#{@key}, #{@val}"
  end
end

class LinkedList
  include Enumerable
  attr_reader :head

  def initialize
    @head = Link.new
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.nxt
  end

  def last
    current_link = @head

    until current_link.nxt == nil
      current_link = current_link.nxt
    end

    current_link
  end

  def empty?
    @head.nxt == nil
  end

  def get(key)
    each { |link| return link.val if link.key == key }
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key }
    false
  end

  def insert(key, val)
    last.nxt = Link.new(key, val, nil, last)
  end

  def remove(key)
    each do |link|
      if link.key == key
        link.prev.nxt = link.nxt
      end
    end
  end

  def each(&block)
    return self if @head.nxt == nil
    current_link = @head.nxt

    until current_link.nxt.nil?
      block.call(current_link)
      current_link = current_link.nxt
    end
    
    block.call(current_link)
    self
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
