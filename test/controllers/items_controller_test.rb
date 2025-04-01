require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should not save item without info" do
    item = Item.new
    assert_not item.save, "Saved item without info"
  end
end
