import consumer from "channels/consumer"

let subscription = null;

const connectToRepairChannel = () => {
  console.log('turbo:load event fired');
  const repairContainer = document.getElementById('repair_container');

  if (repairContainer) {
    const repairId = repairContainer.dataset.repairId;
    if (repairId) {
      // Unsubscribe from any existing subscription
      if (subscription) {
        subscription.unsubscribe();
        console.log('Unsubscribed from existing repair channel');
      }

      // Subscribe to the RepairChannel
      subscription = consumer.subscriptions.create(
        { channel: "RepairChannel", id: repairId },
        {
          connected() {
            console.log('Connected to repair channel');
          },
          disconnected() {
            console.log('Disconnected from repair channel');
          },
          received(data) {
            console.log('Received data from repair channel');
            const repairDiv = document.getElementById(`repair_${repairId}`);
            if (repairDiv) {
              repairDiv.innerHTML = data.html;
            }
          }
        }
      );
    } else {
      console.error("Could not find repair ID.");
    }
  }
};

const disconnectFromRepairChannel = () => {
  if (subscription) {
    subscription.unsubscribe();
    console.log('Unsubscribed from repair channel');
    subscription = null;
  }
};

// Connect when the page loads
document.addEventListener('turbo:load', connectToRepairChannel);

// Disconnect before the page is replaced
document.addEventListener('turbo:before-render', disconnectFromRepairChannel);

// Disconnect when the user navigates away
window.addEventListener('beforeunload', disconnectFromRepairChannel);




