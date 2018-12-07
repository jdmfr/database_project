class Post < ApplicationRecord
	validates_presence_of  :body
	validates :body , presence: true ,length: {maximum: 140}
	default_scope -> { order(created_at: :desc) }
	has_many :comments , :dependent => :destroy
    belongs_to :user

end
