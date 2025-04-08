require "test_helper"

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get all inventories" do
    inventories = Inventory.all
    assert inventories, "Could not find all inventories"
  end
end
