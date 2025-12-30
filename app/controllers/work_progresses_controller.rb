class WorkProgressesController < ApplicationController
  before_action :set_book_specification
  before_action :set_work_progress, only: [:show, :edit, :update]

  def index
    @work_progresses = WorkProgress.all

    @sort_list = [
      ["未完了が上順", "incomplete_first"],
      ["完了が上順", "complete_first"],
      ["作成日が新しい順", "newest"]
    ]

    @sorted = params[:sort]

    @work_progresses = WorkProgress.includes(:book_specification)

    if @sorted.present? && WorkProgress.respond_to?(@sorted)
      @work_progresses = @work_progresses.public_send(@sorted)
    end
  end

  def new
  end

  def create
    @work_progress = @book_specification.work_progresses.build(work_progress_params)
    if @work_progress.save
      redirect_to book_specification_work_progresses_path(@book_specification), notice: "作業進捗情報を新規登録しました"
    else
      flash[:alert] = "作業進捗を新規登録できませんでした"
      render "book_specifications/show", status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @work_progress.update(work_progress_params)
      flash[:notice] = "作業進捗を変更しました"
      redirect_to book_specification_work_progresses_path(@book_specification), notice: "作業進捗を更新しました"
    else
      flash[:alert] = "作業進捗を変更できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def set_book_specification
      @book_specification = BookSpecification.find(params[:book_specification_id])
    end

    def set_work_progress
      @work_progress = @book_specification.work_progresses.find(params[:id])
    end

    def work_progress_params
      params.require(:work_progress).permit(:status, :floor, :comment, :start_time, :end_time, :manager)
    end
end
