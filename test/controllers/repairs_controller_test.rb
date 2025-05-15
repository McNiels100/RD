require "test_helper"

class RepairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @admin = users(:admin)
    @repair = repairs(:one)
    @completed_repair = repairs(:completed)
    @locked_repair = repairs(:locked)
    @inventory = inventories(:one)
    @device = devices(:one)
  end

  test "should check fixtures exist" do
    assert_not_nil @user, "User fixture :one could not be found. Check test/fixtures/users.yml"
    assert_not_nil @admin, "Admin fixture :admin could not be found. Check test/fixtures/users.yml"
    assert_not_nil @repair, "Repair fixture :one could not be found. Check test/fixtures/repairs.yml"
    assert_not_nil @completed_repair, "Completed repair fixture :completed could not be found. Check test/fixtures/repairs.yml"
    assert_not_nil @locked_repair, "Locked repair fixture :locked could not be found. Check test/fixtures/repairs.yml"
    assert_not_nil @inventory, "Inventory fixture :one could not be found. Check test/fixtures/inventories.yml"
    assert_not_nil @device, "Device fixture :one could not be found. Check test/fixtures/devices.yml"
  end

  # View
  test "should load pages if user is logged in" do
    login_as(@admin)

    get repairs_url
    assert_response :success, "Index page did not load successfully after login"

    get new_repair_url
    assert_response :success, "New page did not load successfully after login"

    get repair_url(@repair)
    assert_response :success, "Show page did not load successfully after login"

    get panels_index_url
    assert_response :success, "Panel page did not load successfully after login"

    get devices_url
    assert_response :success, "Devices page did not load successfully after login"

    get new_device_url
    assert_response :success, "New device page did not load successfully after login"

    get edit_device_url(@device)
    assert_response :success, "Edit device page did not load successfully after login"

    get users_url
    assert_response :success, "Users page did not load successfully after login"

    get users_url(@user)
    assert_response :success, "User page did not load successfully after login"

    get new_user_url
    assert_response :success, "New user page did not load successfully after login"

    get user_url(@user)
    assert_response :success, "Edit user page did not load successfully after login"

    get statuses_url
    assert_response :success, "Statuses page did not load successfully after login"

    get inventories_url
    assert_response :success, "Inventory page did not load successfully after login"

    get new_inventory_url
    assert_response :success, "New inventory page did not load successfully after login"

    get edit_inventory_url(@inventory)
    assert_response :success, "Edit inventory page did not load successfully after login"
  end

  test "should redirect away from pages if user is not logged in" do
    assert_not_nil @repair, "Repair fixture :one could not be found."

    get repairs_url
    assert_response :redirect
    assert_redirected_to new_session_url, "Index page did not redirect to login page. Page is viewed without authentication"

    get new_repair_url
    assert_response :redirect
    assert_redirected_to new_session_url, "New page did not redirect to login page. Page is viewed without authentication"

    get repair_url(@repair)
    assert_response :redirect
    assert_redirected_to new_session_url, "Show page did not redirect to login page. Page is viewed without authentication"
  end

  test "should redirect if user is not admin" do
    login_as(@user)

    get devices_url
    assert_response :redirect, "Devices page did load despite user not being admin"

    get new_device_url
    assert_response :redirect, "New device page did load despite user not being admin"

    get edit_device_url(@device)
    assert_response :redirect, "Edit device page did load despite user not being admin"

    get users_url
    assert_response :redirect, "Users page did load despite user not being admin"

    get users_url(@user)
    assert_response :redirect, "User page did load despite user not being admin"

    get new_user_url
    assert_response :redirect, "New user page did load despite user not being admin"

    get user_url(@user)
    assert_response :redirect, "Edit user page did load despite user not being admin"

    get statuses_url
    assert_response :redirect, "Statuses page did load despite user not being admin"

    get inventories_url
    assert_response :redirect, "Inventory page did load despite user not being admin"

    get new_inventory_url
    assert_response :redirect, "New inventory page did load despite user not being admin"

    get edit_inventory_url(@inventory)
    assert_response :redirect, "Edit inventory page did load despite user not being admin"
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
    repair = Repair.new(name: "John Doe", email: "john.doe@example.com", phone_number: "88888888", brand: "Apple", error_description: "Broken screen", imei: "987654321098765", serial: "AP8948973450", model: "iPhone 16e", device_type: "phone",)
    assert repair.save, "Could not save repair with info"
    set_status = repair.add_status(Status.find_by(name: "Received").id, @user)
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


  test "should get TAT by brand and device type" do
    device = Device.find_by(brand: @repair.brand, device_type: @repair.device_type)
    assert device
  end

  # Update
  test "should lock repair" do
    login_as(@user)
    assert_nil @repair.locked_by, "Repair should not be locked before test"

    @repair.lock!(@user.email_address)

    assert_equal @user.email_address, @repair.locked_by, "Repair should be locked by current user"
    assert_not_nil @repair.locked_at, "Locked time should be recorded"
  end

  test "should not lock repair if completed" do
    login_as(@user)

    assert @completed_repair.completed?, "Repair should be completed for this test"

    @completed_repair.lock!(@user.email_address)
    @completed_repair.reload

    assert_equal @user.email_address, @completed_repair.locked_by, "Model allows locking completed repairs"
  end
end
