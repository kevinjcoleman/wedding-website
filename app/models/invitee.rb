class Invitee < ApplicationRecord
  belongs_to :invite_group
  validates :name, presence: true
end
