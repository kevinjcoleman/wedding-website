class AddPlusOneNameToInvitee < ActiveRecord::Migration[5.1]
  def change
    add_column :invitees, :plus_one_name, :string
  end
end
