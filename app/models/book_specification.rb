class BookSpecification < ApplicationRecord
  has_many :work_progresses, dependent: :destroy

  validates :title, presence: true
  validates :number_of_copies, presence: true
  validates :number_of_machines, presence: true
  validates :deadline, presence: true
  validates :author, presence: true
  validate :deadline_after_today

  scope :sorted, ->(sort) {
    case sort
    when "number_of_copies_desc"
      order(number_of_copies: :desc)
    when "number_of_copies_asc"
      order(number_of_copies: :asc)
    when "deadline_desc"
      order(deadline: :desc)
    when "deadline_asc"
      order(deadline: :asc)
    else
      order(id: :asc)
    end
  }

  private

  def deadline_after_today
    return if deadline.blank?
    if deadline < Date.current
      errors.add(:deadline, "納期は今日以降の日付を選択してください")
    end
  end
end
