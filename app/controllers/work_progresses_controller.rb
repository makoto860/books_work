class WorkProgressesController < ApplicationController
  before_action :set_book_specification
  before_action :set_work_progress, only: [:show, :edit, :update]

  def index
    @work_progresses_sort_list = [
      ["未完了順", "status_asc"],
      ["完了順", "status_desc"],
      ["部数が多い順", "number_copies_desc"],
      ["部数が少ない順", "number_copies_asc"],
      ["階数が高い順", "floor_desc"],
      ["階数が低い順", "floor_asc"],
      ["納期が近い順", "deadline_desc"],
      ["納期が遠い順", "deadline_asc"]
    ]

    @work_progresses = WorkProgress.includes(:book_specification).sorted(params[:sort])
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
