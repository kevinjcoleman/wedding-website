json.inviteName @invite_group
json.rsvped @invite_group.rsvped
json.invitees @invite_group.invitees do |invitee|
  json.id invitee.id
  json.name invitee.name
  json.plusOneEligible invitee.plus_one
  json.hasPlusOne invitee.plus_one_name.present?
  json.plusOneName invitee.plus_one_name
  json.confirmed invitee.confirmed
end 