class WorkProgress < ApplicationRecord
  belongs_to :book_specification

  validates :status, presence: true
  validates :floor, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :manager, presence: true
  validate :start_time_after_today
  validate :end_time_before_start_time

  private

  def start_time_after_today
    return if start_time.blank?
    if start_time < Date.current
      errors.add(:start_time, "開始時間は今日以降の日付を選択してください")
    end
  end

  def end_time_before_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "終了時間は開始時間以降の日付を選択してください") if end_time < start_time
  end
end
