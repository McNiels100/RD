# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# Load seeds in production using bin/kamal console with command 'kamal app exec 'rails db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1''
# Reboot app container with bin/kamal app reboot

def create_statuses
  Status.delete_all

  Status.create!([
    { name: "Received", active: true },
    { name: "Diagnosing", active: true },
    { name: "Waiting for Parts", active: true },
    { name: "In Repair", active: true },
    { name: "Testing", active: true },
    { name: "Ready for Pickup", active: true },
    { name: "Completed", active: true },
    { name: "Cancelled", active: false },
    { name: "Re-opened", active: true }
  ])
end

def create_users
  User.destroy_all

  user = User.create!(
    email_address: "admin@company.com",
    password: "admin123",
    password_confirmation: "admin123",
    role: "admin",
    name: "Nicklas Jensen"
  )

  user = User.create!(
    email_address: "leader@company.com",
    password: "leader123",
    password_confirmation: "leader123",
    role: "leader",
    name: "Ronan Larson"
  )

  user = User.create!(
    email_address: "technician@company.com",
    password: "technician123",
    password_confirmation: "technician123",
    role: "technician",
    name: "Louise Thomson"
  )

  user = User.create!(
    email_address: "alice.smith@company.com",
    password: "alice123",
    password_confirmation: "alice123",
    role: "technician",
    name: "Alice Smith"
  )

  user = User.create!(
    email_address: "bob.johnson@company.com",
    password: "bob123",
    password_confirmation: "bob123",
    role: "technician",
    name: "Bob Johnson"
  )

  user = User.create!(
    email_address: "charlie.brown@company.com",
    password: "charlie123",
    password_confirmation: "charlie123",
    role: "technician",
    name: "Charlie Brown"
  )

  user = User.create!(
    email_address: "david.wilson@company.com",
    password: "david123",
    password_confirmation: "david123",
    role: "technician",
    name: "David Wilson"
  )

  user = User.create!(
    email_address: "eve.davis@company.com",
    password: "eve123",
    password_confirmation: "eve123",
    role: "technician",
    name: "Eve Davis"
  )

  user = User.create!(
    email_address: "frank.miller@company.com",
    password: "frank123",
    password_confirmation: "frank123",
    role: "technician",
    name: "Frank Miller"
  )

  user = User.create!(
    email_address: "grace.lee@company.com",
    password: "grace123",
    password_confirmation: "grace123",
    role: "technician",
    name: "Grace Lee"
  )

  user = User.create!(
    email_address: "hank.martin@company.com",
    password: "hank123",
    password_confirmation: "hank123",
    role: "technician",
    name: "Hank Martin"
  )

  user = User.create!(
    email_address: "ivy.clark@company.com",
    password: "ivy123",
    password_confirmation: "ivy123",
    role: "technician",
    name: "Ivy Clark"
  )

  user = User.create!(
    email_address: "jack.lewis@company.com",
    password: "jack123",
    password_confirmation: "jack123",
    role: "technician",
    name: "Jack Lewis"
  )

  user = User.create!(
    email_address: "john.smith@company.com",
    password: "smith123",
    password_confirmation: "smith123",
    role: "admin",
    name: "John Smith"
  )

  user = User.create!(
    email_address: "emily.johnson@company.com",
    password: "emily123",
    password_confirmation: "emily123",
    role: "leader",
    name: "Emily Johnson"
  )

  user = User.create!(
    email_address: "micheal.brown@company.com",
    password: "micheal123",
    password_confirmation: "micheal123",
    role: "leader",
    name: "Michael Brown"
  )

  user = User.create!(
    email_address: "sarah.davis@company.com",
    password: "sarah123",
    password_confirmation: "sarah123",
    role: "leader",
    name: "Sarah Davis"
  )
end

def create_devices
  Device.delete_all

  device = Device.create!(
    brand: 'Apple',
    device_type: 'phone',
    tat_neutral: 1,
    tat_unsatisfied: 2,
    tat_very_unsatisfied: 3
  )

  device = Device.create!(
    brand: 'Apple',
    device_type: 'tablet',
    tat_neutral: 5,
    tat_unsatisfied: 10,
    tat_very_unsatisfied: 18
  )

  device = Device.create!(
    brand: 'Apple',
    device_type: 'computer',
    tat_neutral: 2,
    tat_unsatisfied: 5,
    tat_very_unsatisfied: 14
  )

  device = Device.create!(
    brand: 'Apple',
    device_type: 'wearable',
    tat_neutral: 5,
    tat_unsatisfied: 10,
    tat_very_unsatisfied: 18
  )

  device = Device.create!(
    brand: 'Apple',
    device_type: 'accessory',
    tat_neutral: 2,
    tat_unsatisfied: 5,
    tat_very_unsatisfied: 14
  )

  device = Device.create!(
    brand: 'Samsung',
    device_type: 'phone',
    tat_neutral: 7,
    tat_unsatisfied: 14,
    tat_very_unsatisfied: 30
  )

  device = Device.create!(
    brand: 'Samsung',
    device_type: 'tablet',
    tat_neutral: 7,
    tat_unsatisfied: 14,
    tat_very_unsatisfied: 30
  )

  device = Device.create!(
    brand: 'Samsung',
    device_type: 'computer',
    tat_neutral: 15,
    tat_unsatisfied: 20,
    tat_very_unsatisfied: 30
  )

  device = Device.create!(
    brand: 'Samsung',
    device_type: 'wearable',
    tat_neutral: 10,
    tat_unsatisfied: 15,
    tat_very_unsatisfied: 20
  )

  device = Device.create!(
    brand: 'Samsung',
    device_type: 'accessory',
    tat_neutral: 7,
    tat_unsatisfied: 14,
    tat_very_unsatisfied: 30
  )

  device = Device.create!(
    brand: 'Sony',
    device_type: 'console',
    tat_neutral: 14,
    tat_unsatisfied: 25,
    tat_very_unsatisfied: 30
  )

  device = Device.create!(
    brand: 'ASRock',
    device_type: 'hardware',
    tat_neutral: 14,
    tat_unsatisfied: 25,
    tat_very_unsatisfied: 30
  )

  device = Device.create!(
    brand: 'OnePlus',
    device_type: 'phone',
    tat_neutral: 2,
    tat_unsatisfied: 5,
    tat_very_unsatisfied: 10
  )

  device = Device.create!(
    brand: 'Xiaomi',
    device_type: 'phone',
    tat_neutral: 2,
    tat_unsatisfied: 5,
    tat_very_unsatisfied: 10
  )

  device = Device.create!(
    brand: 'Nvidia',
    device_type: 'hardware',
    tat_neutral: 10,
    tat_unsatisfied: 15,
    tat_very_unsatisfied: 30
  )
end

def create_repairs
  Repair.delete_all

  repair = Repair.create!(
    name: 'Nicklas Jensen',
    email: 'nicklas@example.com',
    phone_number: 88888888,
    brand: 'Samsung',
    error_description: %(When I read e-boks on it, the device suddenly powers off. It cannot be powered on again if I do not wait about 10 min.),
    imei: 4545616199875432,
    serial: 'R5KNFES127ZE9H',
    model: 'S23 FE',
    model_code: 'SM-S711B/DS',
    device_type: 'phone'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user


  repair = Repair.create!(
    name: 'Ronan Larson',
    email: 'ronan@example.com',
    phone_number: 68012585,
    brand: 'Apple',
    error_description: %(The drops the connection all the time. While browsing, having calls or watching videoes on YouTube. It also drains the battery way faster than advertised. The camera also takes incorrect photos. The color is not natural. I have a ton of problems with it and I want my money back! All the problems were there before I dropped the phone and broke the rear cover.),
    imei: 138768580228309,
    serial: 'SA8028SA3463',
    model: 'iPhone 15 Pro 128GB Black',
    model_code: 'A2848',
    device_type: 'phone',
    created_at: 3.day.ago,
    updated_at: 3.day.ago
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Farhan Thomson',
    email: 'farhan@example.com',
    phone_number: 42805096,
    brand: 'Samsung',
    error_description: %(The screen is broken and the customer want it fixed.),
    imei: 405512728981185,
    serial: 'SA1234SA5678',
    model: 'Galaxy S25',
    model_code: 'SM-S931B/DS',
    device_type: 'phone'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Karina Newman',
    email: 'karina@example.com',
    phone_number: 95122445,
    brand: 'Apple',
    error_description: %(The rear camera cracked when she dropped the phone. She want it repaired with her insurance.),
    imei: 180324452041849,
    serial: 'SA2345SA6789',
    model: 'iPhone 13 Pro White',
    model_code: 'A2638',
    device_type: 'phone'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Laurie Schwartz',
    email: 'laurie@example.com',
    phone_number: 82828850,
    brand: 'OnePlus',
    error_description: %(The speaker scratches when it gets cold.),
    imei: 404691323879560,
    serial: 'SA3456SA7890',
    model: '13R',
    model_code: 'CPH2645',
    device_type: 'phone',
    created_at: 3.day.ago,
    updated_at: 3.day.ago
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Laurie Schwartz',
    email: 'laurie@example.com',
    phone_number: 82828850,
    brand: 'OnePlus',
    error_description: %(The previous repair did not fix the problem. The speaker still scratches when it gets cold.),
    imei: 404691323879560,
    serial: 'SA3456SA7890',
    model: '13R',
    model_code: 'CPH2645',
    device_type: 'phone'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Melisa Bridges',
    email: 'melisa@example.com',
    phone_number: 57304746,
    brand: 'Samsung',
    error_description: %(DOA. The S-pen cannot track. Sometimes you can poke with it. But is impossible to draw one line without it breaking. It was like it when I opened the sales box.),
    imei: 425230367890870,
    model: 'S25 Ultra',
    model_code: 'SM-S938B/DS',
    device_type: 'phone',
    created_at: 31.day.ago,
    updated_at: 2.day.ago
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Chanelle Joyce',
    email: 'chanelle@example.com',
    phone_number: 68987658,
    brand: 'Apple',
    error_description: %(My iPhone was dropped in a little bit of water which it is supposed to be able to survive. Now it cannot boot. I want it fixed on warranty!),
    imei: 630576122387474,
    serial: 'SA5678SA9012',
    model: 'iPhone 14 Red',
    model_code: 'A2783',
    device_type: 'phone',
    created_at: 2.day.ago,
    updated_at: 2.day.ago
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Chanelle Joyce',
    email: 'chanelle@example.com',
    phone_number: 68987658,
    brand: 'Apple',
    error_description: %(My phone was returned without repair last time because I did not respond to a repair offer. This is unacceptable!!! I want a new phone as it was clearly defect from the factory. I will press charges if you return the phone again!!!!),
    imei: 630576122387474,
    serial: 'SA5678SA9012',
    model: 'iPhone 14 Black',
    model_code: 'A2882',
    device_type: 'phone',
    created_at: 15.day.ago,
    updated_at: 10.day.ago
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Chanelle Joyce',
    email: 'chanelle@example.com',
    phone_number: 68987658,
    brand: 'Apple',
    error_description: %(This is now 3rd repair without you doing shit with my phone. I am sueing your ass if you dare send another cost estimate or whatever you call it. The phone legaly should be exchanged to a new one!!!!!!!),
    imei: 630576122387474,
    serial: 'SA5678SA9012',
    model: 'iPhone 14',
    model_code: 'A2882',
    device_type: 'phone'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Connor Friedman',
    email: 'connor@example.com',
    phone_number: 12230018,
    brand: 'Sony',
    error_description: %(My Dead Space Remake CD is stuck inside the PlayStation.),
    serial: 'SA6789SA0123',
    model: 'PS5 slim disc',
    model_code: 'CFI-2016',
    device_type: 'console',
    created_at: 26.day.ago,
    updated_at: 10.day.ago
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Anisha Clark',
    email: 'anisha@example.com',
    phone_number: 69266916,
    brand: 'Xiaomi',
    error_description: %(It takes hours to charge with the origianl charger. I have tried with other chargers but it is the same. I think the problem lies with the phone. But I am not sure so I will let you guys to it. Please fix it on warranty.),
    imei: 659189344230575,
    serial: 'SA7890SA1234',
    model: '14T Pro Blue',
    model_code: '2407FPN8EG',
    device_type: 'phone'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Jay Underwood',
    email: 'jay@example.com',
    phone_number: 91724280,
    brand: 'Samsung',
    error_description: %(The charger cable is beginning to crack. I have just used it normally for less than a year. Thus it must be exchanged as I for a fact know it cannot be repaired. I want the same original Samsung cable. Not any other color.),
    serial: "SM3945999547",
    model: 'Samsung cable',
    device_type: 'accessory'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  repair = Repair.create!(
    name: 'Calvin Finch',
    email: 'calvin@example.com',
    phone_number: 30421415,
    brand: 'ASRock',
    error_description: %(DOA. A RAM slot does not work. The one to the farthest right.),
    serial: "AS9284739",
    model: 'X870E Taichi',
    device_type: 'hardware'
  )
  repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user

  10.times do
    repair = Repair.create!(
      name: 'Johnny Bravo',
      email: 'johnny.bravo@flexing.com',
      phone_number: 564989616,
      brand: 'Apple',
      error_description: %(I broke 10 phones while flexing at ladies. Hello, 911? I just spotted a fox!),
      imei: rand(1000000),
      model: 'iPhone 15 Pro Max',
      model_code: 'A3106',
      device_type: 'phone'
    )
    repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user
  end

  10.times do
    repair = Repair.create!(
      name: 'Sly Cooper',
      email: 'sly.cooper@theif.com',
      phone_number: 988976685,
      brand: 'Apple',
      error_description: %(I somehow ended up buying 10 phones. And none of them work. They loose connection all the time.),
      imei: rand(1000000),
      model: 'iPhone 15 Pro',
      model_code: 'A3102',
      device_type: 'phone'
    )
    repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user
  end

  5.times do
    repair = Repair.create!(
      name: 'Annoying Scalper',
      email: 'scalper@flexing.com',
      phone_number: 78892144,
      brand: 'Nvidia',
      error_description: %(My 5090's are missing ROPs.),
      serial: "NV#{rand(1000000)}",
      model: 'RTX 5090 FE',
      device_type: 'hardware',
      created_at: 15.day.ago,
      updated_at: 15.day.ago
    )
    repair.add_status(Status.find_by(name: "Received").id, User.last) # Using User.last as the acting user
    repair.add_status(Status.find_by(name: "Waiting for Parts").id, User.last) # Using User.last as the acting user
  end
end

def create_inventories
  Inventory.delete_all

  5.times do
    inventory = Inventory.create!(
      brand: 'Samsung',
      model: 'Galaxy S23 FE',
      model_code: 'SM-S711B/DS',
      part_name: 'Display',
      part_number: 'SVC-LCD-ASSY-OCTA',
      serial: "SM#{(10**14) + rand(10**15 - 10**14)}",
      location: "B7"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'Apple',
      model: 'iPhone 15 Pro',
      model_code: 'A2848',
      part_name: 'Battery',
      part_number: '661-35694',
      serial: "AP#{(10**14) + rand(10**15 - 10**14)}",
      location: "A1"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'OnePlus',
      model: '13R',
      model_code: 'CPH2645',
      part_name: 'Speaker',
      part_number: 'O-SPEAKER-BOTTOM-R',
      serial: "OP#{(10**14) + rand(10**15 - 10**14)}",
      location: "C3"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'Xiaomi',
      model: '14T Pro',
      model_code: '2407FPN8EG',
      part_name: 'Mainboard',
      part_number: 'XM-MAINBOARD-128',
      imei: (10**14) + rand(10**15 - 10**14),
      location: "E2"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'OnePlus',
      model: '13R',
      model_code: 'CPH2645',
      part_name: 'Display',
      part_number: 'O-AMOLED-DIS',
      serial: "OP#{(10**14) + rand(10**15 - 10**14)}",
      location: "C4"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'OnePlus',
      model: '13R',
      model_code: 'CPH2645',
      part_name: 'Mainboard',
      part_number: 'O-MAINBOARD-128',
      imei: (10**14) + rand(10**15 - 10**14),
      location: "C2"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'OnePlus',
      model: '13R',
      model_code: 'CPH2645',
      part_name: 'Subboard',
      part_number: 'O-SUBBOARD-USB',
      serial: "OP#{(10**14) + rand(10**15 - 10**14)}",
      location: "C2"
    )
  end

  5.times do
    inventory = Inventory.create!(
      brand: 'Samsung',
      model: 'Galaxy S23 FE',
      model_code: 'SM-S711B/DS',
      part_name: 'Mainboard',
      part_number: 'SVC-MAINBOARD-128-INTER',
      imei: (10**14) + rand(10**15 - 10**14),
      location: "B6"
    )
  end
end

def create_pricings
  Pricing.create!(
    part_number: "SVC-LCD-ASSY-OCTA",
    price: 234.99,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "661-35694",
    price: 59.99,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "O-SPEAKER-BOTTOM-R",
    price: 19.99,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "XM-MAINBOARD-128",
    price: 349.99,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "O-AMOLED-DIS",
    price: 229.99,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "O-MAINBOARD-128",
    price: 320,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "O-SUBBOARD-USB",
    price: 99.99,
    effective_date: Date.today
  )

  Pricing.create!(
    part_number: "SVC-MAINBOARD-128-INTER",
    price: 329.99,
    effective_date: Date.today
  )
end

create_statuses
create_users
create_devices
create_repairs
create_inventories
create_pricings
