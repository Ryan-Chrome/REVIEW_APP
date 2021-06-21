class ReportsController < ApplicationController
  before_action :login_user
  
  def index
    @report = Report.all
  end

  def show
    @report = Report.find_by(params[:id])
  end

  def new
    @review = Review.find_by(id: params[:review_id])
    @report = Report.new
  end

  def create
    @report = current_user.reports.build(report_params)
    if @report.save
      redirect_to review_path(@report.review)
    end
  end

  private

    def report_params
      params.require(:report).permit(:subject, :content, :review_id)
    end
end
