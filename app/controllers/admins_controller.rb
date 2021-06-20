class AdminsController < ApplicationController
  def index
    @users = User.all
    @reviews = Review.all
  end

  private

  def admin_valid
    unless current_user.admin?
      redirect_to request.referer
    end
  end
end
