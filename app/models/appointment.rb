class Appointment < ApplicationRecord

  validates :app_date, uniqueness: { scope: :place_id  , message: "already appointed! Please retry ." }

  belongs_to :place
  belongs_to :group
end
