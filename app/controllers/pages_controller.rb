class PagesController < ApplicationController

    before_action :login_user, only: [:show, :follow]

    def home 
        if user_signed_in?
            redirect_to show_path(current_user)
        end
    end

    def show
        @user = User.find(params[:id])
        @reviews = @user.reviews.paginate(page: params[:page], per_page: 40)
        @all_reviews = @user.reviews
        @like_count = 0
        @all_reviews.each do |review|
            count = review.review_relationships.count.to_i
            @like_count += count
        end
    end

    def follow
        @reviewers = current_user.followings.paginate(page: params[:page], per_page: 40)
    end
end