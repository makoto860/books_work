class BookSpecification < ApplicationRecord
  has_many :work_progresses, dependent: :destroy

  def work_progresses_new
    work_progresses.new
  end
end
