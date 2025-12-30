class WorkProgress < ApplicationRecord
  belongs_to :book_specification

  validates :status, presence: true
  validates :floor, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :manager, presence: true
  validate :start_time_after_today
  validate :end_time_after_start_time

  scope :incomplete, -> { order(status: :asc) }
  scope :complete,   -> { order(status: :desc) }
  scope :newest,           -> { order(created_at: :desc) }
  scope :editest,           -> { order(created_at: :asc) }
  scope :floor_high, -> { order(floor: :desc) }
  scope :floor_low,  -> { order(floor: :asc) }
  # 部数が多い順
  scope :copies_desc, -> { joins(:book_specification).order('book_specifications.number_of_copies DESC') }
  # 部数が少ない順
  scope :copies_asc, -> { joins(:book_specification).order('book_specifications.number_of_copies ASC') }

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
