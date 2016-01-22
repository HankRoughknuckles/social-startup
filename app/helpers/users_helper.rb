module UsersHelper

  # returns a link to the passed user's projects page
  def projects_page_link(user)
    link_to "Projects", user_projects_path(user), class: "show_projects"
  end


  def edit_profile_link(user)
    link_to "Edit Account", edit_user_registration_path(user), class: "edit_profile"
  end


  # returns comma separated spans each with the passed users interest tags
  def interest_list user
    raw user.interest_list.collect { |interest| 
      content_tag(:span, interest, class: "interest")
    }.join(", ")
  end
end
