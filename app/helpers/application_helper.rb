module ApplicationHelper
  def nav_link_active(controller_action)
    controller.action_name == controller_action ? 'active' : ''
  end 
end
