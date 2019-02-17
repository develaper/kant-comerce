#!/usr/bin/env ruby
require 'minitest/autorun'
require 'minitest/pride'
require './lib/basket/item'

class ItemTest < Minitest::Test
  def test_intialize_to_new_item
    code, name, price = ["GR1", "Green Tea", 3.11]
    assert_equal Item, Item.new(code, name, price).class
  end

  def test_exception_if_price_not_numeric
    assert_raises ArgumentError do
      code, name, price = ["GR1", "Green Tea", "two"]
      Item.new(code, name, price)
    end
  end

  def test_exception_if_price_negative
    assert_raises ArgumentError do
      code, name, price = ["GR1", "Green Tea", -5]
      Item.new(code, name, price)
    end
  end
end
