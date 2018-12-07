class Place < ApplicationRecord
	validates :name ,presence: :true,uniqueness: :true
	has_many :appointments , dependent: :destroy
	
end
