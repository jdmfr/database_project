class Group < ApplicationRecord
  has_many :appointments
  belongs_to :user
end
