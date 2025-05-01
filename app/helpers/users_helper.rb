module UsersHelper
  def navigation_links(user)
    links = []
    links << link_to("Account", "", class: "active") if user.admin? || user.leader? || user.technician?
    links << link_to("Change password", "") if user.admin? || user.leader? || user.technician?
    links << link_to("Manage users", users_path) if user.admin?
    links << link_to("Manage devices", devices_path) if user.admin?
    links << link_to("Manage statuses", statuses_path) if user.admin?
    links << link_to("Manage inventories", inventories_path) if user.admin?
    links << link_to("Excel export", "") if user.admin? || user.leader?
    links.join.html_safe
  end

  def repair_actions(user)
    buttons = []
    # Turbo_confirm does not work for some reason. Thus onclick used instead.
    buttons << button_to("Re-open", reopen_repair_path(@repair), method: :patch, onclick: "return confirm('Are you sure you want to re-open this repair?');") if (user.admin? || user.leader?) && @repair.completed?
    buttons.join.html_safe
  end
end
