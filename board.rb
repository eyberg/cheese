class Board

  def initialize(width, height)
    @data = Array.new(width) { Array.new(height) }
  end

  def rows
    @data.size.times
  end

  def row(x)
    @data[x]
  end

  def get(x, y)
    @data[x.to_i][y.to_i] || "\s"
  end

  def set(x, y, value)
    @data[x.to_i][y.to_i] = value
  end

end
