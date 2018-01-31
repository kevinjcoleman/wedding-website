class AddOptionalLastNameToInvitee < ActiveRecord::Migration[5.1]
  def change
    add_column :invitees, :optional_last_name, :string
  end
end
