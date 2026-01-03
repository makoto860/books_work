class BookSpecificationsController < ApplicationController
  before_action :set_book_specification, only: [:show, :edit, :update, :destroy]

  def index
    @book_specifications = BookSpecification.all

    @book_specification_sort_list = [
      ["部数(多い順)", "number_of_copies_desc"],
      ["部数(少ない順)", "number_of_copies_asc"],
      ["納期(新しい順)", "deadline_desc"],
      ["納期(古い順)", "deadline_asc"]
    ]

    @book_specifications = BookSpecification.sorted(params[:sort])
  end

  def new
    @book_specification = BookSpecification.new
  end

  def create
    @book_specification = BookSpecification.new(book_specification_params)
    if @book_specification.save
      flash[:notice] = "仕様書IDの#{@book_specification.id}を新規登録しました"
      redirect_to book_specifications_path
    else
      flash[:alert] = "仕様書IDの#{@book_specification.id}を新規登録できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @work_progresses = @book_specification.work_progresses
    @work_progress = @book_specification.work_progresses.build
  end

  def edit
  end

  def update
    if @book_specification.update(book_specification_params)
      flash[:notice] = "仕様書IDの#{@book_specification.id}を変更しました"
      redirect_to book_specifications_path
    else
      flash[:alert] = "仕様書IDが#{@book_specification.id}の情報を更新できませんでした"
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @book_specification.destroy
    flash[:notice] = "仕様書を削除しました"
    redirect_to book_specifications_path
  end

  private

  def set_book_specification
    @book_specification = BookSpecification.find(params[:id])
  end

  def book_specification_params
    params.require(:book_specification).permit(:title, :number_of_copies, :number_of_machines, :note, :deadline, :author)
  end
end
