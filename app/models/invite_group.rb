class InviteGroup < ApplicationRecord
  extend FriendlyId
  friendly_id :invite_name, use: :slugged
  validates :invite_name, presence: true
  has_many :invitees, dependent: :destroy
  
  def update_with_params(params)
    params.each do |invitee|
      self.invitees.find(invitee[:id]).update_attributes(invitee_params(invitee))
    end 
  end 
  
  def invitee_params(invitee_param)
    {name: invitee_param[:name],
     plus_one: invitee_param[:plusOneEligible],
     plus_one_name: invitee_param[:plusOneName],
     confirmed: invitee_param[:confirmed]}
  end 
end
