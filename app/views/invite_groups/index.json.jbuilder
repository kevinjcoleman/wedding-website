json.inviteGroups @invite_groups do |group|
  json.name group.invite_name
  json.inviteeString group.invitees.pluck(:name).join(', ')
  json.editUrl invite_group_path(group)
end