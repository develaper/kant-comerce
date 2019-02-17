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

  def test_exception_if_discount_fraction_not_numeric
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,2 ,"1")
    end
  end

  def test_exception_if_discount_fraction_negative
    assert_raises ArgumentError do
      MinimumPurchaseGetDiscount.new("CF1" ,2 ,-1)
    end
  end

  def test_no_discount_applyed_when_quantity_is_below
    rule = MinimumPurchaseGetDiscount.new("CF1" ,3 ,3)
    total = rule.apply(1, 11.23)
    assert_equal 11.23, total
  end

  def test_discount_applyed_when_quantity_is_equal_to_minimum_purchase
    rule = MinimumPurchaseGetDiscount.new("CF1" ,3 ,3)
    total = rule.apply(3, 11.23)
    assert_equal 22.46, total
  end

  def test_discount_applyed_when_quantity_is_bigger_than_minimum_purchase
    rule = MinimumPurchaseGetDiscount.new("CF1" ,3 ,3)
    total = rule.apply(6, 11.23)
    assert_equal 44.92, total
  end
end
