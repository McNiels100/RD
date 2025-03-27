require "test_helper"

# Create
class RepairsControllerTest < ActionDispatch::IntegrationTest
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

  test "should save repair with all info filled" do
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
    repair = Repair.find(1)
    assert repair
  end

  test "should get TAT by brand and device type" do
    repair = Repair.find(0)
    device = Device.find_by(brand: repair.brand, device_type: repair.device_type)
    assert device
  end
end
