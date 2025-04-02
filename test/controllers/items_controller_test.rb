require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should not save item without info" do
    item = Item.new
    assert_not item.save, "Saved item without info"
  end

  test "should not save item that already exists" do
    item = Item.create(sku_prefix: "SAM-S25E-256-BLU-", description: "Samsung Galaxy S25 Edge 256GB Blue", base_price: 1099.00, category: "phone", active: true)
    assert_not item.save, "Saved item that already exists"
  end

  test "should not save item without SKU-prefix" do
    item = Item.new(description: "Samsung Galaxy S25 Edge 256GB Blue", base_price: 1099.00, category: "phone", active: true)
    assert_not item.save, "Saved item without SKU-prefix"
  end

  test "should not save item without description" do
    item = Item.new(sku_prefix: "SAM-S25E-256-BLU-", base_price: 1099.00, category: "phone", active: true)
    assert_not item.save, "Saved item without description"
  end

  test "should not save item with price lower than 0" do
    item = Item.new(sku_prefix: "SAM-S25E-256-BLU-", description: "Samsung Galaxy S25 Edge 256GB Blue", base_price: -1099.00, category: "phone", active: true)
    assert_not item.save, "Saved item with price lower than 0"
  end
end
