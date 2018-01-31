class AddPlusOneToInvitee < ActiveRecord::Migration[5.1]
  def change
    add_column :invitees, :plus_one, :boolean
  end
end
