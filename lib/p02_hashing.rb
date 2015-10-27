class Array
  def hash(base = 12)
    string = ""
    self.each { |el| string << el.to_s }
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
    map { |k, v| [k, v] }.sort.hash(10)
  end
end
