class RsvpNotifier
  def initialize(invite_group)
    @invite_group = invite_group
  end 

  def send 
    if @invite_group.rsvped
      msg = {
        attachments: [{
          fallback: "Kevin, there's a new RSVP from #{@invite_group.invitees.map(&:name).join(", ")} #{@invite_group.invite_name}",
          color: "#049bff",
          title: "Kevin, there's a new RSVP from #{@invite_group.invitees.map(&:name).join(", ")} #{@invite_group.invite_name}",
          #title_link: "https://www.legalnature.com/admin/leads/#{@user.lead.id}",
          mrkdwn_in: ["fields"],
          fields: fields,
          ts: Time.now.to_i
        }]
      }
    else 
      msg = {
        attachments: [{
          fallback: "Kevin, there's a new decline from #{@invite_group.invitees.map(&:name).join(", ")} #{@invite_group.invite_name}",
          color: "#ff0000",
          title: "Kevin, there's a new decline from #{@invite_group.invitees.map(&:name).join(", ")} #{@invite_group.invite_name}",
          #title_link: "https://www.legalnature.com/admin/leads/#{@user.lead.id}",
          ts: Time.now.to_i
        }]
      }
    end 
    HTTParty.post "https://hooks.slack.com/services/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", body: msg.to_json
  end 
  
  def fields 
    arr = @invite_group.invitees.map do |invitee|
      [name_field(invitee), attending_field(invitee), plus_one_field(invitee)].compact
    end.flatten
    [{title: "",
      value: arr.compact.join("\n")}]
  end 
  
  def decline_fields
    str = @invite_group.invitees.map(&:name).join(", ")
    [{title: "",
      value: str}]
  end 
  
  def plus_one_field(invitee)
    if invitee.plus_one_name
      "*Plus one name:* #{invitee.plus_one_name}"
    else 
      nil
    end 
  end 
  
  def name_field(invitee) 
    "*Name:* #{invitee.name}"
  end 
  
  def attending_field(invitee)
    "*Attending:* #{invitee.confirmed}"
  end   
end 