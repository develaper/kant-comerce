#!/usr/bin/env ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/pricing_rules/minimum_purchase_get_discount'

class MinimumPurchaseGetDiscountTest < Minitest::Test
  def test_intialize_to_new_rule
    assert_equal MinimumPurchaseGetDiscount, MinimumPurchaseGetDiscount.new("CF1" ,1 ,50).class
  end

  def test_exception_if_minimun_purchase_not_numeric
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,"1" ,50)
    end
  end

  def test_exception_if_minimun_purchase_negative
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,-2 ,1)
    end
  end

  def test_exception_if_discount_percent_not_numeric
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,2 ,"1")
    end
  end

  def test_exception_if_discount_percent_negative
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,2 ,-1)
    end
  end

  def test_exception_if_discount_percent_bigger_than_100
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,2 ,150)
    end
  end

  def test_no_discount_applyed_when_quantity_is_below
    rule = MinimumPurchaseGetDiscount.new("CF1" ,2 ,10)
    total = rule.apply(1, 100)
    assert_equal 100, total
  end

  def test_discount_applyed_when_quantity_is_equal_to_minimum_purchase
    rule = MinimumPurchaseGetDiscount.new("CF1" ,2 ,10)
    total = rule.apply(2, 100)
    assert_equal 180, total
  end

  def test_discount_applyed_when_quantity_is_bigger_than_minimum_purchase
    rule = MinimumPurchaseGetDiscount.new("CF1" ,2 ,10)
    total = rule.apply(4, 100)
    assert_equal 360, total
  end
end
