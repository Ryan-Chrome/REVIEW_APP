# encoding: utf-8
class ReviewsController < ApplicationController
  before_action :login_user
  before_action :current_user?, only: [:edit, :update]

  def show
    @review = Review.find(params[:id])
  end

  def index
    if !params[:search].present? && !params[:category].present?
      @reviews_category = [
        ["書籍", 0, "books.jpg"],
        ["DVD・ミュージック・ゲーム", 0, "music.jpg"],
        ["家電・カメラ・AV機器", 0, "camera.jpg"],
        ["パソコン・オフィス用品", 0, "office.jpg"],
        ["ホーム・キッチン・ベッド・DIY", 0, "home.jpg"],
        ["食品・飲料・お酒", 0, "food.jpg"],
        ["薬・美容", 0, "beauty.jpg"],
        ["ホビー", 0, "toy.jpg"],
        ["衣類・装飾品", 0, "clothing.jpg"],
        ["スポーツ", 0, "gym.jpg"],
        ["アウトドア", 0, "camp.jpg"],
        ["車・バイク", 0, "cars.jpg"],
        ["お店", 0, "store.jpg"],
        ["観光地", 0, "itary.jpg"],
        ["その他", 0, "other.jpg"],
      ]
      reviews = Review.all
      @reviews_category.each do |cate|
        count = reviews.select { |n| n.category == cate[0] }.length
        cate[1] = count
      end
    end
    if params[:search].present?
      @reviews = Review.where(
        "name LIKE ?", "%#{params[:search]}%"
      ).paginate(page: params[:page], per_page: 40).with_attached_image1
    end
    if params[:category].present?
      @reviews = Review.where(
        "category = ?", params[:category]
      ).paginate(page: params[:page], per_page: 40).with_attached_image1
    end
  end

  def new
    @review = current_user.reviews.build()
  end

  def create
    @review = current_user.reviews.build(params_review)
    if @review.save
      redirect_to user_path(current_user)
    else
      render "new"
    end
  end

  def edit
    gon.image1_attach = @review.image1.attached?
    gon.image2_attach = @review.image2.attached?
    gon.image3_attach = @review.image3.attached?
    gon.image4_attach = @review.image4.attached?
    gon.image5_attach = @review.image5.attached?
  end

  def update
    @review.update(params_review)
    redirect_to @review
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user == current_user
      @review.image1.purge if @review.image1.attached?
      @review.image2.purge if @review.image2.attached?
      @review.image3.purge if @review.image3.attached?
      @review.image4.purge if @review.image4.attached?
      @review.image5.purge if @review.image5.attached?
      @review.destroy
      redirect_to user_path(current_user)
    else
      redirect_to @review
    end
  end

  private

  def params_review
    params.require(:review).permit(
      :name, :category, :rate, :content,
      :image1, :image2, :image3, :image4, :image5
    )
  end

  def current_user?
    @review = Review.find(params[:id])
    redirect_to show_path(current_user) if @review.user != current_user
  end
end
