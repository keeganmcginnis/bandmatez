class UserFriendshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:new]

  def new
    if params[:friend_id]
      @friend = User.where(profile_name: params[:friend_id]).first
      raise ActiveRecord::RecordNotFound if @friend.nil?
      @user_friendship = current_user.user_friendships.new(friend: @friend)
    else   
      flash[:error] = "Friend Required"
    end 

    def accept
      @user_friendship = current_user.user_friendships.find(params[:id])
      if @user_friendship.accept!
        flash[:success] = "You are now friends with #{@user_friendship}"
      else
        flash[:error] = "Sorry, your freindship was not accepted."
    end

    def edit
       @user_friendship = current_user.user_friendships.find(params[:id])
       @friend = user_friendship.friend
      
    end

  rescue ActiveRecord::RecordNotFound
    render file: 'public/404', status: :not_found
  end

  def create
    if params[:friend_id]
      @friend = User.find(params[:friend_id])

      if current_user.friends.include?(@friend)
        flash[:error] = "Already friended"
        redirect_to profile_path(@friend.profile_name)

      elsif @friend == current_user
        flash[:error] = "You can't friend yourself"
        redirect_to profile_path(@friend.profile_name)
      else

        @user_friendship = current_user.user_friendships.new(friend: @friend)

        if @user_friendship.save
          flash[:notice] = "Friend sucessfully saved"
          redirect_to profile_path(@friend.profile_name)
        else
          flash[:error] = "Friend not sucessfully saved"
          redirect_to profile_path(@friend.profile_name)
        end
      end
    else
      flash[:error] = "Friend Required. Sorry, bud!"    
      redirect_to root_path
    end
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    # def user_friendships_params
    #   params.permit(:friend_id)
    # end
end
