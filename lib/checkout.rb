class Checkout
  attr_accessor :items
  def initialize
    @items = Hash.new
  end

  def scan(item)
    if new_product?(item.code)
      @items[item.code] = { "quantity" => 1, "price" => item.price }
    else
      @items[item.code]["quantity"] += 1
    end
  end

  def total
    total = 0
    @items.each_value { |value| total += (value["price"] * value["quantity"]) }
    total.round(2)
  end

  def new_product?(item_code)
    true unless @items[item_code]
  end

end
