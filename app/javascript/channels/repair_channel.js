import consumer from "channels/consumer"

const repairContainer = document.getElementById('repair_container');
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
