require 'csv'

class InviteGroupImporter
  def self.import!
    CSV.foreach(Rails.root.join('db', 'fixtures', 'invites.csv'), headers: true) do |row|
      import_row(row)
    end 
  end 
  
  def self.import_row(row)
    group = InviteGroup.create!(invite_name: row['name'])
    raise 'Needs invitees!' unless row['invitees'].present?
    invitees = row['invitees'].split(',')
    invitees.each do |invite|
      is_child = invite.match?(/\|/)
      is_plus_one = invite.match?(/\+/)
      first_name, last_name = invite.gsub(/[\|\+]/, '').split(' ')
      group.invitees.create!(name: first_name, 
                             optional_last_name: last_name,
                             child: is_child,
                             plus_one: is_plus_one,
                             confirmed: true)
    end 
  end 
end 