class InviteGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @invite_groups = InviteGroup.all
  end

  def show
    @invite_group = InviteGroup.find_by(slug: params[:id])
  end
  
  def update 
    group = InviteGroup.find_by(slug: params[:id])
    group.update_with_params(params["_json"])
    RsvpNotifier.new(group.reload).send
    head :ok
  end 
  
  def cancel 
    group = InviteGroup.find_by(slug: params[:invite_group_id])
    group.update_attributes(rsvped: false)
    group.invitees.find_each do |invitee|
      invitee.update_attributes(confirmed: false)
    end
    RsvpNotifier.new(group.reload).send
    head :ok
  end 
end
