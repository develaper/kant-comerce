#!/usr/bin/env ruby
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/checkout'
require './lib/item'

class ItemTest < Minitest::Test
  def test_intialize_to_new_checkout
    assert_equal Checkout, Checkout.new().class
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
  def test_total_returns_full_price_with_one_product_various_items
    co = Checkout.new
    item = Item.new("GR1", "Green Tea", 3.11)
    co.scan(item)
    co.scan(item)
    assert_equal(6.22, co.total)
  end
  def test_total_returns_full_price_with_various_products_various_items
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
end
