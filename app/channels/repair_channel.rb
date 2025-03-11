class RepairChannel < ApplicationCable::Channel
  def subscribed
    # Find the repair and lock it for the current user
    repair = Repair.find(params[:id])
    repair.lock!(current_user.email_address) if repair && current_user

    # Stream updates for this repair
    stream_from "repair_#{params[:id]}"
  end

  def unsubscribed
    # Find the repair and unlock it when the user unsubscribes
    repair = Repair.find(params[:id])
    repair.unlock! if repair && repair.locked_by?(current_user.email_address)
  end
end
