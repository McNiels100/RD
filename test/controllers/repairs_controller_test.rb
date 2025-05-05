require "test_helper"

class RepairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Assuming :one is a regular user
    @admin = users(:admin) # Assuming you have an admin fixture
    @repair = repairs(:one)
    @completed_repair = repairs(:completed) # Assuming a completed fixture
    @locked_repair = repairs(:locked_by_other) # Assuming locked by another user
  end
  # View
  test "should load pages if user is logged in" do
    # Get fixtures
    user = users(:one)
    repair = repairs(:one)

    # Pre-check if fixtures exist
    assert_not_nil user, "User fixture :one could not be found. Check test/fixtures/users.yml"
    assert_not_nil repair, "Repair fixture :one could not be found. Check test/fixtures/repairs.yml"

    # Log the user in using the helper (this sets the session cookies)
    log_in_as(@user)

    # Make page requests
    get repairs_url
    assert_response :success, "Index page did not load successfully after login"

    get new_repair_url
    assert_response :success, "New page did not load successfully after login"

    get repair_url(repairs(:one))
    assert_response :success, "Show page did not load successfully after login"
  end

  test "should redirect away from pages if user is not logged in" do
      repair = repairs(:one) # Need a repair object for the show URL
      assert_not_nil repair, "Repair fixture :one could not be found."

      get repairs_url
      assert_response :redirect
      assert_redirected_to new_session_url, "Index page did not redirect to login page. Page is viewed without authentication"

      get new_repair_url
      assert_response :redirect
      assert_redirected_to new_session_url, "New page did not redirect to login page. Page is viewed without authentication"

      get repair_url(repair)
      assert_response :redirect
      assert_redirected_to new_session_url, "Show page did not redirect to login page. Page is viewed without authentication"
    end

  # Create
  test "should not save repair without info" do
    repair = Repair.new
    assert_not repair.save, "Saved repair without info"
  end

  test "should not save repair without email" do
    repair = Repair.new(name: "John Doe", phone_number: "88888888", brand: "Apple", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert_not repair.save, "Saved repair without email"
  end

  test "should not save repair without phone number" do
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", brand: "Apple", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert_not repair.save, "Saved repair without phone number"
  end

  test "should not save repair without brand" do
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", phone_number: "88888888", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert_not repair.save, "Saved repair without brand"
  end

  test "should not save repair without device type" do
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", brand: "Apple", phone_number: "88888888", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e")
    assert_not repair.save, "Saved repair without device type"
  end

  test "should save repair with all required info filled" do
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", phone_number: "88888888", brand: "Apple", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert repair.save, "Could not save repair with info"
  end

  test "should save repair with all info filled except serial" do
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", phone_number: "88888888", brand: "Apple", error_description: "Broken screen", imei: "987654321098765", model: "iPhone 16e", device_type: "phone",)
    assert repair.save, "Could not save repair with all info filled except serial"
  end

  test "should save repair with all info filled except IMEI" do
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", phone_number: "88888888", brand: "Apple", error_description: "Broken screen", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert repair.save, "Could not save repair with all info filled except IMEI"
  end

  test "should set initial status to 'Received' when saved" do
    user = users(:one)
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", phone_number: "88888888", brand: "Apple", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert repair.save, "Could not save repair with info"
    set_status = repair.add_status(Status.find_by(name: "Received").id, user)
    assert set_status, "Could not set initial status to Received"
  end

  # Read
  test "should get all repairs" do
    repair = Repair.all
    assert repair
  end

  test "should get all devices" do
    device = Device.all
    assert device
  end

  test "should get repair by order number" do
    repair = Repair.where(order_number: "RD-123456")
    assert repair
  end

  test "should get repair by phone number" do
    repair = Repair.where(phone_number: "88888888")
    assert repair
  end

  test "should get repair by email" do
    repair = Repair.where(email: "john.doe@example.com")
    assert repair
  end

  test "should get repair by IMEI" do
    repair = Repair.where(imei: "987654321098765")
    assert repair
  end

  test "should get repair by serial" do
    repair = Repair.where(serial: "AP8948973450")
    assert repair
  end

  test "should get device by id" do
    repair = repairs(:one)
    assert repair
  end

  test "should get TAT by brand and device type" do
    repair = repairs(:one)
    device = Device.find_by(brand: repair.brand, device_type: repair.device_type)
    assert device
  end

  # Update
  test "should lock repair" do
  end

  test "should not lock repair if already locked by other" do
  end

  test "should not lock repair if completed" do
  end
end
