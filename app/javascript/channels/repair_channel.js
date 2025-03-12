import consumer from "channels/consumer"

document.addEventListener('turbo:load', () => { // Listen for turbo:load event
  console.log('turbo:load event fired');
  const repairContainer = document.getElementById('repair_container');

  if (repairContainer) {
    const repairId = repairContainer.dataset.repairId;
    if (repairId) {
      consumer.subscriptions.create({ channel: "RepairChannel", id: repairId }, {
        connected() {
          console.log('connected to repair channel');
        },
        disconnected() {
          console.log('disconnected from repair channel');
        },
        received(data) {
          console.log('received data from repair channel');
          document.getElementById(`repair_${repairId}`).innerHTML = data.html;
        }
      });
    } else {
      console.error("Could not find repair ID.");
    }
  }
});




