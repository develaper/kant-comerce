class Item

  attr_accessor :code, :name, :price

  def initialize(code, name, price)
    @code = code.to_s
    @name = name.to_s
    @price = price

    validate!
  end

  def validate!
    raise ArgumentError.new("Price must be a positive number") unless @price.is_a? Numeric and @price > 0
  end
end
