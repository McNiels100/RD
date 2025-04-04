require "test_helper"

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get all inventories" do
    inventories = Inventory.all
    assert inventories
  end
end
