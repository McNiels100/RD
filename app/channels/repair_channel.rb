class RepairChannel < ApplicationCable::Channel
  def subscribed
    stream_from "repair_#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
