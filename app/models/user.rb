class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :posts, dependent: :destroy

  
         has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
         has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
         
         has_many :following, through: :active_relationships, source: :followed
         has_many :followers, through: :passive_relationships, source: :follower
         
  action_store :like, :group , counter_cache: true
  action_store :like, :project , counter_cache: true
         # helper methods
         
         # follow another user
         def follow(other)
           active_relationships.create(followed_id: other.id)
         end
         
         # unfollow a user
         def unfollow(other)
           active_relationships.find_by(followed_id: other.id).destroy
         end
         
         # is following a user?
         def following?(other)
           following.include?(other)
         end
    #     has_many :active_relationships ,class_name: "Relationship", foreign_key: "follower_id" , dependent: :destroy
    #     has_many :passive_relationships , class_name: "Relationship" , foreign_key: "followed_id", dependent: :destroy
    #     has_many :following , through: :active_relationships , source: followed
    #     has_many :followers , through: :passive_relationships , source: follower


    #     def follow(other)
    #     	active_relationships.create(followed_id: other.id)
    #     end

    #     def unfollow(other)
    #     	active_relationships.find_by(followed_id: other.id).destroy
    #     end
    def name 
    	self.email.split('@')[0].capitalize
    end


     #    def following?(other)
      #   	following.include?(other)
       #  end


end
