require "./lib/pricing_rules/pricing_rule"
require "./lib/pricing_rules/buy_minimum_purchase_get_free_product"
require "./lib/pricing_rules/minimum_purchase_get_discount"
require './lib/basket/checkout'
require './lib/basket/item'


print "select a use case:"
use_case = gets.chomp
case use_case.to_i

when 1
  puts "your use case is #{use_case}"
  puts "Basket: GR1,SR1,GR1,GR1,CF1"
  puts "Total price expected: £22.45"
  pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
  puts "pr1 = BuyMinimumPurchaseGetFreeProduct.new(\"GR1\",2 ,1)"
  pr2 = MinimumPurchaseGetDiscount.new("SR1",3 ,10)
  puts "pr2 = MinimumPurchaseGetDiscount.new(\"SR1\",3 ,10)"
  pr3 = MinimumPurchaseGetDiscount.new("CF1",3 ,33)
  puts "pr3 = MinimumPurchaseGetDiscount.new(\"CF1\",3 ,33)"
  pricing_rules = [pr1, pr2, pr3]
  puts "pricing_rules = [pr1, pr2, pr3]"
  co = Checkout.new(pricing_rules)
  puts "co = Checkout.new(pricing_rules)"
  item = Item.new("GR1", "Green Tea", 3.11)
  puts "item = Item.new(\"GR1\", \"Green Tea\", 3.11)"
  item2 = Item.new("SR1", "Strawberries", 5.00)
  puts "item2 = Item.new(\"SR1\", \"Strawberries\", 5.00)"
  item3 = Item.new("CF1", "Coffee", 11.23)
  puts "item3 = Item.new(\"CF1\", \"Coffee\", 11.23)"
  co.scan(item)
  puts "co.scan(item)"
  co.scan(item2)
  puts "co.scan(item2)"
  co.scan(item)
  puts "co.scan(item)"
  co.scan(item)
  puts "co.scan(item)"
  co.scan(item3)
  puts "co.scan(item3)"
  puts "co.total = #{co.total}"
when 2
  puts "Basket: GR1,GR1"
  puts "Total price expected: £3.11"
  pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
  puts "pr1 = BuyMinimumPurchaseGetFreeProduct.new(\"GR1\",2 ,1)"
  pricing_rules = [pr1]
  puts "pricing_rules = [pr1]"
  co = Checkout.new(pricing_rules)
  puts "co = Checkout.new(pricing_rules)"
  item = Item.new("GR1", "Green Tea", 3.11)
  puts "item = Item.new(\"GR1\", \"Green Tea\", 3.11)"
  co.scan(item)
  puts "co.scan(item)"
  co.scan(item)
  puts "co.scan(item)"
  puts "co.total = #{co.total}"
when 3
  puts "Basket: SR1,SR1,GR1,SR1"
  puts "Total price expected: £16.61"
  pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
  puts "pr1 = BuyMinimumPurchaseGetFreeProduct.new(\"GR1\",2 ,1)"
  pr2 = MinimumPurchaseGetDiscount.new("SR1",3 ,10)
  puts "pr2 = MinimumPurchaseGetDiscount.new(\"SR1\",3 ,10)"
  pr3 = MinimumPurchaseGetDiscount.new("CF1",3 ,33)
  puts "pr3 = MinimumPurchaseGetDiscount.new(\"CF1\",3 ,33)"
  pricing_rules = [pr1, pr2, pr3]
  puts "pricing_rules = [pr1, pr2, pr3]"
  co = Checkout.new(pricing_rules)
  puts "co = Checkout.new(pricing_rules)"
  item = Item.new("GR1", "Green Tea", 3.11)
  puts "item = Item.new(\"GR1\", \"Green Tea\", 3.11)"
  item2 = Item.new("SR1", "Strawberries", 5.00)
  puts "item2 = Item.new(\"SR1\", \"Strawberries\", 5.00)"
  item3 = Item.new("CF1", "Coffee", 11.23)
  puts "item3 = Item.new(\"CF1\", \"Coffee\", 11.23)"
  co.scan(item2)
  puts "co.scan(item2)"
  co.scan(item2)
  puts "co.scan(item2)"
  co.scan(item)
  puts "co.scan(item)"
  co.scan(item2)
  puts "co.scan(item2)"
  puts "co.total = #{co.total}"
when 4
  puts "Basket: GR1,CF1,SR1,CF1,CF1"
  puts "Total price expected: £30.57"
  pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
  puts "pr1 = BuyMinimumPurchaseGetFreeProduct.new(\"GR1\",2 ,1)"
  pr2 = MinimumPurchaseGetDiscount.new("SR1",3 ,10)
  puts "pr2 = MinimumPurchaseGetDiscount.new(\"SR1\",3 ,10)"
  pr3 = MinimumPurchaseGetDiscount.new("CF1",3 ,33)
  puts "pr3 = MinimumPurchaseGetDiscount.new(\"CF1\",3 ,33)"
  pricing_rules = [pr1, pr2, pr3]
  puts "pricing_rules = [pr1, pr2, pr3]"
  co = Checkout.new(pricing_rules)
  puts "co = Checkout.new(pricing_rules)"
  item = Item.new("GR1", "Green Tea", 3.11)
  puts "item = Item.new(\"GR1\", \"Green Tea\", 3.11)"
  item2 = Item.new("SR1", "Strawberries", 5.00)
  puts "item2 = Item.new(\"SR1\", \"Strawberries\", 5.00)"
  item3 = Item.new("CF1", "Coffee", 11.23)
  puts "item3 = Item.new(\"CF1\", \"Coffee\", 11.23)"
  co.scan(item)
  puts "co.scan(item)"
  co.scan(item3)
  puts "co.scan(item3)"
  co.scan(item2)
  puts "co.scan(item2)"
  co.scan(item3)
  puts "co.scan(item3)"
  co.scan(item3)
  puts "co.scan(item3)"
  puts "co.total = #{co.total}"
else
  puts "we only have 4 use cases defined"
end
