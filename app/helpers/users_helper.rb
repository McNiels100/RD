module UsersHelper
  def navigation_links(user)
    links = []
    links << link_to("Account", "") if user.admin? || user.leader? || user.technician?
    links << link_to("Change password", "") if user.admin? || user.leader? || user.technician?
    links << link_to("Manage users", users_path) if user.admin?
    links << link_to("Manage devices", devices_path) if user.admin?
    links << link_to("Excel export", "") if user.admin? || user.leader?
    links.join.html_safe
  end
end
