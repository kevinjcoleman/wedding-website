class CreateInviteGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :invite_groups do |t|
      t.string :invite_name

      t.timestamps
    end
  end
end
