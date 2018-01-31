class InviteGroupsController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @invite_groups = InviteGroup.all
  end

  def show
    @invite_group = InviteGroup.find_by(slug: params[:id])
  end
  
  def update 
    InviteGroup.find_by(slug: params[:id]).update_with_params(params["_json"])
  end 
end
