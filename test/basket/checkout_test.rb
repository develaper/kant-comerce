#!/usr/bin/env ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/basket/checkout'
require './lib/basket/item'
require './lib/pricing_rules/buy_minimum_purchase_get_free_product'
require './lib/pricing_rules/minimum_purchase_get_discount'

class ItemTest < Minitest::Test
  def test_intialize_to_new_checkout
    assert_equal Checkout, Checkout.new().class
  end
  def test_exception_if_pricing_rules_are_not_pricing_rules
    assert_raises ArgumentError do
      pricing_rules = ["GR1", "SR1"]
      Checkout.new(pricing_rules)
    end
  end

  def test_initialize_adds_rules_to_each_item
    pr1 = MinimumPurchaseGetDiscount.new("CF1" ,1 ,50)
    pricing_rules = [pr1]
    co = Checkout.new(pricing_rules)
    assert_equal(co.items["CF1"]["pricing_rule"], pr1)
  end
  def test_scan_adds_first_item_to_checkout
    co = Checkout.new
    item = Item.new("GR1", "Green Tea", 3.11)
    co.scan(item)
    assert_equal(co.items["GR1"]["quantity"], 1)
  end
  def test_scan_adds_second_item_to_checkout
    co = Checkout.new
    item = Item.new("GR1", "Green Tea", 3.11)
    co.scan(item)
    co.scan(item)
    assert_equal(co.items["GR1"]["quantity"], 2)
    assert_equal(co.items["GR1"]["price"], 3.11)
  end
  def test_total_returns_full_price_with_one_product_various_items_without_pricing_rules
    co = Checkout.new
    item = Item.new("GR1", "Green Tea", 3.11)
    co.scan(item)
    co.scan(item)
    assert_equal(6.22, co.total)
  end
  def test_total_returns_full_price_with_various_products_various_items_without_pricing_rules
    co = Checkout.new
    item = Item.new("GR1", "Green Tea", 3.11)
    item2 = Item.new("SR1", "Strawberries", 5.00)
    co.scan(item)
    co.scan(item)
    co.scan(item2)
    co.scan(item2)
    co.scan(item2)
    assert_equal(21.22, co.total)
  end
  def test_total_applies_pricing_rules_with_one_product_various_items
    pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
    pricing_rules = [pr1]
    co = Checkout.new(pricing_rules)
    item = Item.new("GR1", "Green Tea", 3.11)
    co.scan(item)
    co.scan(item)
    assert_equal(3.11, co.total)
  end

  #EVALUATION CASES
  def test_total_applies_pricing_rules_with_multiple_product_various_items_case_1
    #Basket: GR1,SR1,GR1,GR1,CF1
    #Total price expected: £22.45
    pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
    pr2 = MinimumPurchaseGetDiscount.new("SR1",3 ,10)
    pr3 = MinimumPurchaseGetDiscount.new("CF1",3 ,33)
    pricing_rules = [pr1, pr2, pr3]
    co = Checkout.new(pricing_rules)
    item = Item.new("GR1", "Green Tea", 3.11)
    item2 = Item.new("SR1", "Strawberries", 5.00)
    item3 = Item.new("CF1", "Coffee", 11.23)
    co.scan(item)
    co.scan(item2)
    co.scan(item)
    co.scan(item)
    co.scan(item3)
    assert_equal(22.45, co.total)
  end

  def test_total_applies_pricing_rules_with_multiple_product_various_items_case_2
    #Basket: GR1,GR1
    #Total price expected: £3.11
    pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
    pricing_rules = [pr1]
    co = Checkout.new(pricing_rules)
    item = Item.new("GR1", "Green Tea", 3.11)
    co.scan(item)
    co.scan(item)
    assert_equal(3.11, co.total)
  end

  def test_total_applies_pricing_rules_with_multiple_product_various_items_case_3
    #Basket: SR1,SR1,GR1,SR1
    #Total price expected: £16.61
    pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
    pr2 = MinimumPurchaseGetDiscount.new("SR1",3 ,10)
    pr3 = MinimumPurchaseGetDiscount.new("CF1",3 ,33)
    pricing_rules = [pr1, pr2, pr3]
    co = Checkout.new(pricing_rules)
    item = Item.new("GR1", "Green Tea", 3.11)
    item2 = Item.new("SR1", "Strawberries", 5.00)
    item3 = Item.new("CF1", "Coffee", 11.23)
    co.scan(item2)
    co.scan(item2)
    co.scan(item)
    co.scan(item2)
    assert_equal(16.61, co.total)
  end

  def test_total_applies_pricing_rules_with_multiple_product_various_items_case_4
    #Basket: GR1,CF1,SR1,CF1,CF1
    #Total price expected: £30.57
    pr1 = BuyMinimumPurchaseGetFreeProduct.new("GR1",2 ,1)
    pr2 = MinimumPurchaseGetDiscount.new("SR1",3 ,10)
    pr3 = MinimumPurchaseGetDiscount.new("CF1",3 ,33)
    pricing_rules = [pr1, pr2, pr3]
    co = Checkout.new(pricing_rules)
    item = Item.new("GR1", "Green Tea", 3.11)
    item2 = Item.new("SR1", "Strawberries", 5.00)
    item3 = Item.new("CF1", "Coffee", 11.23)
    co.scan(item)
    co.scan(item3)
    co.scan(item2)
    co.scan(item3)
    co.scan(item3)
    assert_equal(30.57, co.total)
  end

end
