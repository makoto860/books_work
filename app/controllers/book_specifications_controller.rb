class BookSpecificationsController < ApplicationController
  def index
    @book_specifications = BookSpecification.all
  end

  def new
    @book_specification = BookSpecification.new
  end

  def create
    @book_specification = BookSpecification.new(params.require(:book_specification).permit(:title, :number_of_copies, :number_of_machines, :note, :deadline, :author))
    if @book_specification.save
      flash[:notice] = "仕様書を新規登録しました"
      redirect_to :book_specifications
    else
      render "new"
    end
  end

  def show
    @book_specification = BookSpecification.find(params[:id])
  end

  def edit
    @book_specification = BookSpecification.find(params[:id])
  end

  def update
    @book_specification = BookSpecification.find(params[:id])
    if @book_specification.update(params.require(:book_specification).permit(:title, :number_of_copies, :number_of_machines, :note, :deadline, :author))
      flash[:notice] = "仕様書IDの#{@book_specification.id}を変更しました"
      redirect_to :book_specifications
    else
      render "edit"
    end
  end

  def destroy
  end
end
