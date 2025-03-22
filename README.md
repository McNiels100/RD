# RD
RD (short for Repair Device) is a business application to manage repairs for phones, tablets, wearables, computers, accessories and more to come.

View demo at [repair-device.work](https://repair-device.work/)

# Login

| Email                  | Password       |
| ---------------------- | -------------- |
| admin@company.com      | admin123       |
| leader@company.com     | leader123      |
| technician@company.com | technician123  |

# Features
Most noteworthy features to look out for are:

## TAT (Turnaround time) Calculator
When creating a new repair, a associated TAT is given depending on brand and device type chosen. TAT is display on the front page showing the backlog of pending repairs. The stages are:
* Good (Green)
* Neutral (Yellow)
* Unsatisfied (Orange)
* Very unsatisfied (Red)

## Days to next TAT
As a technician it would be more effiecient to know what repairs should be prioritized. Days to next TAT can be seen in the backlog on the front page and on individual repairs in the upper right corner. There will be a little 4-colored diagram with an arrow that can be hovered with the mouse to display TAT stages and days to next stage change. 

## Locked Repair
To hinder technician from working on the same repairs and stopping conflicting saves, each repair will be locked by current user when loaded. A orange banner will be displayed with locked by and time when another used loads a locked repair. The lock will be removed if the technician leaves the repair or closes the browser. 

Admins have the rights to manually unlocked a repair with a button in the banner if they for some reason abseloutly have to. The unlock with be instanous and the other end user working on the repair will be displayed a notification with whom kicked them off. No need to reload the page. The technican will not be wasting his time not knowing that they are unable to save what they are working on.

## New Repair
Made for shop assistants to quickly create repairs and give customers the information regarding if they can handle a specific brand by device type. And how long it would take to repair the device. All information must be filled except IMEI or Serial. Both cannot be empty.

## User Panel
Can be accessed by all users but shows diffrent content depending on account rights. Actions need specific level of rights or higher:

Admins can:
* Manage the list of devices being handled which includes TAT stages.
* Generate Excel reports.

Leaders can:
* Mange user accounts for the company. Create, update or delete.

Technicians can: 
* Change password.
* Show account level.

# Functionality yet to come
* Create orders for businesses.
* Repair statusses
* Actually generate excel reports.
* Buying and receiving parts/devices.
* Inventory re-counting.
* Adding brands and claiming API's.
