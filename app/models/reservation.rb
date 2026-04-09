class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  # 必須項目の設定
  validates :start_date, :end_date, :person_count, presence: true
  # 予約人数は1人以上
  validates :person_count, numericality: { greater_than_or_equal_to: 1 }

  # カスタムバリデーション(チェックイン日は今日以降)
  validate :start_date_cannot_be_in_the_past
  # カスタムバリデーション(チェックアウト日はチェックイン日を遡らない)
  validate :end_date_cannot_be_before_start_date

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "は本日以降の日付を選択してください")
    end
  end

  def end_date_cannot_be_before_start_date
    if start_date.present? && end_date.present? && end_date <= start_date
      errors.add(:end_date, "はチェックイン日より後の日付を選択してください")
    end
  end
end
