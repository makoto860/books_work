class WorkProgressesController < ApplicationController
  def index
    @work_progresses = WorkProgresses.all
  end

  def new
  end

  def create
    @book_specification = BookSpecification.find(params[:work_progress][:book_specification_id])
    @work_progress = @book_specification.work_progresses.new(work_progress_params)
  end

  private
    def work_progress_params
      params.require(:work_progress).permit(:status, :floor, :comment, :start_time, :end_time, :manager).merge(book_specification_id: params[:book_specification_id])
    end
end
