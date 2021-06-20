class UsersController < ApplicationController
  before_action :login_user, only: [:show, :follow]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews.paginate(
      page: params[:page], per_page: 40,
    ).with_attached_image1
    @all_reviews = @user.reviews.includes(:review_relationships)
    @like_count = 0
    @all_reviews.each do |review|
      count = review.review_relationships.length.to_i
      @like_count += count
    end
  end

  def follow
    @reviewers = current_user.followings.paginate(
      page: params[:page], per_page: 40,
    ).includes(:reviews).with_attached_image
  end
end
