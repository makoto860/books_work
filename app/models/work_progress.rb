class WorkProgress < ApplicationRecord
  belongs_to :book_specification

  validates :status, presence: true
  validates :floor, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :manager, presence: true
  validate :start_time_after_today
  validate :end_time_after_start_time

  scope :sorted, ->(sort) {
    case sort
    when "status_asc"
      order(status: :asc)
    when "status_desc"
      order(status: :desc)
    when "number_copies_desc"
      joins(:book_specification).order("book_specifications.number_of_copies DESC")
    when "number_copies_asc"
      joins(:book_specification).order("book_specifications.number_of_copies ASC")
    when "floor_desc"
      order(floor: :desc)
    when "floor_asc"
      order(floor: :asc)
    when "deadline_desc"
      joins(:book_specification).order("book_specifications.deadline DESC")
    when "deadline_asc"
      joins(:book_specification).order("book_specifications.deadline ASC")
    else
      order(id: :asc)
    end
  }

  private

  def start_time_after_today
    return if start_time.blank?
    if start_time < Date.current
      errors.add(:start_time, "開始時間は今日からの日付を選択してください")
    end
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "終了時間は開始時間より後の日付を選択してください") if end_time < start_time
  end
end
