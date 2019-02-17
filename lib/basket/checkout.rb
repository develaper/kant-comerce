require "./lib/pricing_rules/pricing_rule"

class Checkout
  attr_accessor :items, :pricing_rules
  def initialize(pricing_rules=[])
    @pricing_rules = pricing_rules
    validate! unless @pricing_rules.empty?
    @items = initialize_pricing_rules
  end

  def scan(item)
    if new_product?(item.code)
      @items[item.code] = { "quantity" => 1, "price" => item.price }
    elsif empty_product?(item.code)
      @items[item.code]["quantity"] = 1
      @items[item.code]["price"] = item.price
    else
      @items[item.code]["quantity"] += 1
    end
  end

  def total
    total = 0
    @items.each do |key, value|
      unless empty_product?(key)
        if value["pricing_rule"]
          total += value["pricing_rule"].apply(value["quantity"], value["price"])
        else
          total += (value["price"] * value["quantity"])
        end
      end
    end
    total.round(2)
  end

  def new_product?(item_code)
    true unless @items[item_code]
  end

  def empty_product?(item_code)
    @items[item_code]["quantity"].nil?
  end

  def validate!
    @pricing_rules.each do |pricing_rule|
      raise ArgumentError.new("Each pricing rule must be a pricing_rule object") unless pricing_rule.is_a? PricingRule
    end
  end

  def initialize_pricing_rules
    @items = Hash.new
    @pricing_rules.each do |pricing_rule|
      @items[pricing_rule.code] = { "pricing_rule" => pricing_rule }
    end
    @items
  end
end
