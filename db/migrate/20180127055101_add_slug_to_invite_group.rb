class AddSlugToInviteGroup < ActiveRecord::Migration[5.1]
  def change
    add_column :invite_groups, :slug, :string
  end
end
