class PagesController < ApplicationController
  def home
  end


  def profile

    if (User.find_by_username(params[:id]))
      @username = params[:id]
    else 
      # redirect to 404 (root for now)
      redirect_to root_path, :notice=> "User not found!" 
    end
    
    @posts = Post.all.where("user_id = ?", User.find_by_username(params[:id]).id)
    @newPost = Post.new
    
    @toFollow = User.all.last(5)
    
  end

  def welcome 

  end

  def explore
    @friends = current_user.following 
    @posts = Post.all.where("user_id = ?" , @friends.ids )


    @newPost = Post.new
    
    @toFollow = User.all.last(5)
  end
end
