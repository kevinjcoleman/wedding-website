json.inviteGroups @invite_groups do |group|
  json.name group.invite_name
  json.inviteeString group.invitees.pluck(:name).join(', ')
  json.editUrl invite_group_path(group)
  json.rsvped group.rsvped
  json.slug group.slug
  json.invitees group.invitees do |invitee|
    json.id invitee.id
    json.name invitee.name
    json.plusOneEligible invitee.plus_one
    json.hasPlusOne invitee.plus_one_name.present?
    json.plusOneName invitee.plus_one_name
    json.confirmed invitee.confirmed
  end 
end