class ReviewRelationshipsController < ApplicationController
  before_action :login_user

  def create
    @review = Review.find(params[:review_id])
    current_user.review_like(@review)
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end

  def destroy
    @review = ReviewRelationship.find(params[:id]).review
    current_user.review_unlike(@review)
    respond_to do |format|
      format.html { redirect_to @review }
      format.js
    end
  end
end
