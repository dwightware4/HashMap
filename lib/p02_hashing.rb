class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash(base = 12)
    string = ""
    self.each { |el| string << el.to_s }
  #  p string
    string.hash(base)
  end
end

class String
  def hash(base = 14)
    self.split('').map { |char| char.ord.to_s(base) }.join.to_i
  end
end

class Hash
  def hash
    # p map { |k, v| [k, v] }.sort
    map { |k, v| [k, v] }.sort.hash(10)
    # string = ""
    # self.keys.sort.each { |key| string << key.to_s }
    # self.values.sort.each { |val| string << val.to_s }
    # string.split('').map { |key| key.ord.to_s(12) }.join.to_i
  end
end
