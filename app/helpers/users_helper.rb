module UsersHelper
  def navigation_links(user)
    links = []
    links << link_to("Add devices", "") if user.admin?
    links << link_to("Create users", "") if user.admin? || user.leader?
    links << link_to("Create parts", "") if user.admin? || user.leader?
    links << link_to("Change password", "") if user.admin? || user.leader? || user.technician?
    links.join.html_safe
  end
end
