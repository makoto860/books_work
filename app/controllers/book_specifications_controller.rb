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
  end

  def update
  end

  def destroy
  end
end
