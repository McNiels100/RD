module StatusesHelper
  def toggle_status_button(status)
    action = status.active? ? "Deactivate" : "Activate"
    color_class = status.active? ? "delete-color" : "edit-color"

    button_to(
      action,
      toggle_active_status_path(status),
      method: :patch,
      class: "btn #{color_class}",
      data: { turbo_confirm: "Are you sure?" }
    )
  end
end
