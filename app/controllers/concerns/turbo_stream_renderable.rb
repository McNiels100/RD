module TurboStreamRenderable
  extend ActiveSupport::Concern

  private
  def render_turbo_flash
    turbo_stream.replace("flash", partial: "layouts/flash")
  end

  def render_repair_items_stream
    render turbo_stream: [
      turbo_stream.replace("repair_parts_#{@repair.id}",
                           partial: "parts",
                           locals: { repair: @repair,
                                     repair_items: @repair.repair_items.order(created_at: :desc) }),
      render_turbo_flash
    ]
  end

  def render_repair_information_stream
    render turbo_stream: [
      turbo_stream.replace("repair_information_#{@repair.id}",
                           partial: "repair_information",
                           locals: { repair: @repair }),
      render_turbo_flash
    ]
  end

  def render_repair_lock_stream(repair_id, locals)
    render turbo_stream: [
      turbo_stream.replace("repair_#{@repair.id}",
                           partial: "repair_lock",
                           locals: locals),
      render_turbo_flash
    ]
  end

  def render_status_history_stream
    render turbo_stream: [
      turbo_stream.replace("status_history_#{@repair.id}",
                           partial: "status_history"),
      render_turbo_flash
    ]
  end
end
