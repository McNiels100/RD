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

  def checkbox_checked?(param_key, value)
    current_values = params[param_key]

    return false if current_values.blank?

    Array(current_values).map(&:to_s).include?(value.to_s)
  end
end
