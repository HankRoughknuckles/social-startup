module UsersHelper

  # returns a link to the passed user's projects page
  def projects_page_link(user)
    link_to "Projects", user_projects_path(user), class: "show_projects"
  end

  def edit_profile_link(user)
    link_to "Edit Account", edit_user_registration_path(user), class: "edit_profile"
  end
end
