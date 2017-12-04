class VectorOperations
  def self.scalar_product(a, b)
    (0...a.count).inject(0) { |sum, i| sum + a[i] * b[i] }
  end

  def self.magnitude(a)
    Math.sqrt(a.map { |x| x**2 }.reduce(:+))
  end
end
