class Task < ApplicationRecord
  validates :task_name, :task_detail, presence: true

  scope :recent_order, -> {order(created_at: :desc)}
  scope :expiry_order_desc, -> {order(expiry_date: :desc)}
  scope :expiry_order_asc, -> {order(expiry_date: :asc)}

  def self.search(search)
    where("task_name LIKE ?", "%#{search}%")
  end
end
