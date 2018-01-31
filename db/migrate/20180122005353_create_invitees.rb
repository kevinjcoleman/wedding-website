class CreateInvitees < ActiveRecord::Migration[5.1]
  def change
    create_table :invitees do |t|
      t.references :invite_group, foreign_key: true
      t.string :name
      t.boolean :child

      t.timestamps
    end
  end
end
