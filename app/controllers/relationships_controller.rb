class RelationshipsController < ApplicationController
  before_action :login_user

  def create
    @user = User.find(params[:follow_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to show_path(@user) }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).follow
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to show_path(@user) }
      format.js
    end
  end
end
