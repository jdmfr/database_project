class RelationshipsController < ApplicationController
    
    def create
        user = User.find(params[:followed_id])
        current_user.follow(user)
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        user = Relationship.find(params[:id]).followed 
        current_user.unfollow(user)
        redirect_back(fallback_location: root_path)
    end
    
end