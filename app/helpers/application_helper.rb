module ApplicationHelper
  def toggle_status_button(resource, path_method)
    action = resource.active? ? "Deactivate" : "Activate"
    color_class = resource.active? ? "delete-color" : "edit-color"

    button_to(
      action,
      path_method,
      method: :patch,
      class: "btn #{color_class}",
      data: { turbo_confirm: "Are you sure?" }
    )
  end
end
