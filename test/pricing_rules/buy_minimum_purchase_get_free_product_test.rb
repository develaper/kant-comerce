#!/usr/bin/env ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/pricing_rules/buy_minimum_purchase_get_free_product'

class BuyMinimumPurchaseGetFreeProductTest < Minitest::Test
  def test_intialize_to_new_rule
    assert_equal BuyMinimumPurchaseGetFreeProduct, BuyMinimumPurchaseGetFreeProduct.new("GR1" ,2 ,1).class
  end

  def test_exception_if_minimun_purchase_not_numeric
    assert_raises ArgumentError do
      BuyMinimumPurchaseGetFreeProduct.new("GR1" ,"2" ,1)
    end
  end

  def test_exception_if_minimun_purchase_negative
    assert_raises ArgumentError do
      BuyMinimumPurchaseGetFreeProduct.new("GR1" ,-2 ,1)
    end
  end

  def test_exception_if_free_quantity_not_numeric
    assert_raises ArgumentError do
      BuyMinimumPurchaseGetFreeProduct.new("GR1" ,2 ,"1")
    end
  end

  def test_exception_if_free_quantity_negative
    assert_raises ArgumentError do
      BuyMinimumPurchaseGetFreeProduct.new("GR1" ,2 ,-1)
    end
  end

  def test_no_discount_applyed_when_quantity_is_below
    rule = BuyMinimumPurchaseGetFreeProduct.new("GR1" ,2 ,1)
    total = rule.apply(1, 2)
    assert_equal 2, total
  end

  def test_discount_applyed_when_quantity_is_equal_to_minimum_purchase
    rule = BuyMinimumPurchaseGetFreeProduct.new("GR1" ,2 ,1)
    total = rule.apply(2, 2)
    assert_equal 2, total
  end

  def test_discount_applyed_when_quantity_is_bigger_than_minimum_purchase
    rule = BuyMinimumPurchaseGetFreeProduct.new("GR1" ,2 ,1)
    total = rule.apply(4, 2)
    assert_equal 4, total
  end
end
