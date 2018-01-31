class AddRsvpedToInviteGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :invite_groups, :rsvped, :boolean
  end
end
