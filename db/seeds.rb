# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Repair orders

Repair.delete_all
repair = Repair.create(name: 'Nicklas Jensen',
  email: 'nicklas@example.com',
  phone_number: 88888888,
  brand: 'Samsung',
  error_description:
    %(When I read e-boks on it, the device suddenly powers off. It cannot be powered on again if I do not wait about 10 min.),
  imei: 4545616199875432,
  serial: 'R5KNFES127ZE9H',
  model: 'S23 FE',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Ronan Larson',
  email: 'ronan@example.com',
  phone_number: 68012585,
  brand: 'Apple',
  error_description:
    %(The drops the connection all the time. While browsing, having calls or watching videoes on YouTube. It also drains the battery way faster than advertised. The camera also takes incorrect photos. The color is not natural. I have a ton of problems with it and I want my money back! All the problems were there before I dropped the phone and broke the rear cover.),
  imei: 138768580228309,
  serial: 'SA8028SA3463',
  model: 'iPhone 15 Pro 128GB Black',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Farhan Thomson',
  email: 'farhan@example.com',
  phone_number: 42805096,
  brand: 'Samsung',
  error_description:
    %(The screen is broken and the customer want it fixed.),
  imei: 405512728981185,
  serial: 'SA1234SA5678',
  model: 'S25',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Karina Newman',
  email: 'karina@example.com',
  phone_number: 95122445,
  brand: 'Apple',
  error_description:
    %(The rear camera cracked when she dropped the phone. She want it repaired with her insurance.),
  imei: 180324452041849,
  serial: 'SA2345SA6789',
  model: 'iPhone 13 Pro White',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Laurie Schwartz',
  email: 'laurie@example.com',
  phone_number: 82828850,
  brand: 'OnePlus',
  error_description:
    %(The speaker scratches when it gets cold.),
  imei: 404691323879560,
  serial: 'SA3456SA7890',
  model: '13R',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Laurie Schwartz',
  email: 'laurie@example.com',
  phone_number: 82828850,
  brand: 'OnePlus',
  error_description:
    %(The previous repair did not fix the problem. The speaker still scratches when it gets cold.),
  imei: 404691323879560,
  serial: 'SA3456SA7890',
  model: '13R',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Melisa Bridges',
  email: 'melisa@example.com',
  phone_number: 57304746,
  brand: 'Samsung',
  error_description:
    %(DOA. The S-pen cannot track. Sometimes you can poke with it. But is impossible to draw one line without it breaking. It was like it when I opened the sales box.),
  imei: 425230367890870,
  model: 'S25 Ultra',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Chanelle Joyce',
  email: 'chanelle@example.com',
  phone_number: 68987658,
  brand: 'Apple',
  error_description:
    %(My iPhone was dropped in a little bit of water which it is supposed to be able to survive. Now it cannot boot. I want it fixed on warranty!),
  imei: 630576122387474,
  serial: 'SA5678SA9012',
  model: 'iPhone 14',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Chanelle Joyce',
  email: 'chanelle@example.com',
  phone_number: 68987658,
  brand: 'Apple',
  error_description:
    %(My phone was returned without repair last time because I did not respond to a repair offer. This is unacceptable!!! I want a new phone as it was clearly defect from the factory. I will press charges if you return the phone again!!!!),
  imei: 630576122387474,
  serial: 'SA5678SA9012',
  model: 'iPhone 14',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Chanelle Joyce',
  email: 'chanelle@example.com',
  phone_number: 68987658,
  brand: 'Apple',
  error_description:
    %(This is now 3rd repair without you doing shit with my phone. I am sueing your ass if you dare send another cost estimate or whatever you call it. The phone legaly should be exchanged to a new one!!!!!!!),
  imei: 630576122387474,
  serial: 'SA5678SA9012',
  model: 'iPhone 14',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Connor Friedman',
  email: 'connor@example.com',
  phone_number: 12230018,
  brand: 'Sony',
  error_description:
    %(My Dead Space Remake CD is stuck inside the PlayStation.),
  serial: 'SA6789SA0123',
  model: 'PS5 slim disc',
  device_type: 'console'
)

repair.save!
# . . .

repair = Repair.create(name: 'Anisha Clark',
  email: 'anisha@example.com',
  phone_number: 69266916,
  brand: 'Xiaomi',
  error_description:
    %(It takes hours to charge with the origianl charger. I have tried with other chargers but it is the same. I think the problem lies with the phone. But I am not sure so I will let you guys to it. Please fix it on warranty.),
  imei: 659189344230575,
  serial: 'SA7890SA1234',
  model: '14T Pro Blue',
  device_type: 'phone'
)

repair.save!
# . . .

repair = Repair.create(name: 'Jay Underwood',
  email: 'jay@example.com',
  phone_number: 91724280,
  brand: 'Samsung',
  error_description:
    %(The charger cable is beginning to crack. I have just used it normally for less than a year. Thus it must be exchanged as I for a fact know it cannot be repaired. I want the same original Samsung cable. Not any other color.),
  model: 'Samsung cable',
  device_type: 'accessory'
)

repair.save!
# . . .

repair = Repair.create(name: 'Calvin Finch',
  email: 'calvin@example.com',
  phone_number: 30421415,
  brand: 'ASRock',
  error_description:
    %(DOA. A RAM slot does not work. The one to the farthest right.),
  model: 'X870E Taichi',
  device_type: 'hardware'
)

repair.save!

# Login users
User.destroy_all
user = User.create! email_address: "test@company.com", password: "test123", password_confirmation: "test123"

user.save!

# . . .
user = User.create! email_address: "user@company.com", password: "user123", password_confirmation: "user123"

user.save!

# Devices and TAT
Device.delete_all
device = Device.create(brand: 'apple',
  device_type: 'phone',
  TAT_neutral: 2,
  TAT_unsatisfied: 5,
  TAT_very_unsatisfied: 14
)

device.save!
# . . .

device = Device.create(brand: 'apple',
  device_type: 'tablet',
  TAT_neutral: 5,
  TAT_unsatisfied: 10,
  TAT_very_unsatisfied: 18
)

device.save!
# . . .

device = Device.create(brand: 'apple',
  device_type: 'computer',
  TAT_neutral: 2,
  TAT_unsatisfied: 5,
  TAT_very_unsatisfied: 14
)

device.save!
# . . .

device = Device.create(brand: 'apple',
  device_type: 'wearable',
  TAT_neutral: 5,
  TAT_unsatisfied: 10,
  TAT_very_unsatisfied: 18
)

device.save!
# . . .

device = Device.create(brand: 'apple',
  device_type: 'acessory',
  TAT_neutral: 2,
  TAT_unsatisfied: 5,
  TAT_very_unsatisfied: 14
)

device.save!
# . . .

device = Device.create(brand: 'samsung',
  device_type: 'phone',
  TAT_neutral: 7,
  TAT_unsatisfied: 14,
  TAT_very_unsatisfied: 30
)

device.save!
# . . .

device = Device.create(brand: 'samsung',
  device_type: 'tablet',
  TAT_neutral: 7,
  TAT_unsatisfied: 14,
  TAT_very_unsatisfied: 30
)
device.save!
# . . .

device = Device.create(brand: 'samsung',
  device_type: 'computer',
  TAT_neutral: 15,
  TAT_unsatisfied: 20,
  TAT_very_unsatisfied: 30
)
device.save!
# . . .

device = Device.create(brand: 'samsung',
  device_type: 'wearable',
  TAT_neutral: 10,
  TAT_unsatisfied: 15,
  TAT_very_unsatisfied: 20
)
device.save!
# . . .

device = Device.create(brand: 'samsung',
  device_type: 'accessory',
  TAT_neutral: 7,
  TAT_unsatisfied: 14,
  TAT_very_unsatisfied: 30
)
device.save!
# . . .

device = Device.create(brand: 'sony',
  device_type: 'console',
  TAT_neutral: 14,
  TAT_unsatisfied: 25,
  TAT_very_unsatisfied: 30
)
device.save!
# . . .

device = Device.create(brand: 'ASRock',
  device_type: 'hardware',
  TAT_neutral: 14,
  TAT_unsatisfied: 25,
  TAT_very_unsatisfied: 30
)
device.save!
# . . .
