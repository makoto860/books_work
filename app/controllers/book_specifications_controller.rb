class BookSpecificationsController < ApplicationController
  def index
    @book_specifications = BookSpecification.all
  end

  def new
    @book_specification = BookSpecification.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
