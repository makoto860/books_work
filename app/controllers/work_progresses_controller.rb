class WorkProgressesController < ApplicationController
  before_action :set_book_specification

  def index
    @work_progresses = @book_specification.work_progresses
  end

  def new
  end

  def create
    @work_progress = @book_specification.work_progresses.build(work_progress_params)
    if @work_progress.save
      redirect_to book_specification_work_progresses_path(@book_specification)
    else
      render "book_specifications/show", status: :unprocessable_entity
    end
  end

  private

    def set_book_specification
      @book_specification = BookSpecification.find(params[:book_specification_id])
    end

    def work_progress_params
      params.require(:work_progress).permit(:status, :floor, :comment, :start_time, :end_time, :manager)
    end
end
