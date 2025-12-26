class BookSpecification < ApplicationRecord
  has_many :work_progresses, dependent: :destroy

  validates :title, presence: true
  validates :number_of_copies, presence: true
  validates :number_of_machines, presence: true
  validates :deadline, presence: true
  validates :author, presence: true
  validate :deadline_after_today

  private

  def deadline_after_today
    return if deadline.blank?
    if deadline < Date.current
      errors.add(:deadline, "納期は今日以降の日付を選択してください")
    end
  end
end
