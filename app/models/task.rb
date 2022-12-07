class Task < ApplicationRecord
  validates :task_name, :task_detail, presence: true

  enum status: {
    未着手: 1,
    着手中: 2,
    完了: 3
  }

  scope :recent_order, -> {order(created_at: :DESC)}
  scope :expiry_order_desc, -> {order(expiry_date: :desc)}
  scope :expiry_order_asc, -> {order(expiry_date: :asc)}

  def self.search(search)
    search[:status] = nil if search[:status].blank?
    if search[:keyword].present? && search[:status]
      Task.where("task_name LIKE ?", "%#{search[:keyword]}%").where(status: search[:status])
    elsif search[:keyword].present?
      Task.where("task_name LIKE ?", "%#{search[:keyword]}%")
    elsif search[:status].present?
      Task.where(status: search[:status])
    else
      Task.all
    end
  end

  def self.sort_search(search)
    if search[:expiry_keyword] == "降順"
      Task.search(search).expiry_order_desc
    elsif search[:expiry_keyword] == "昇順"
      Task.search(search).expiry_order_asc
    else
      Task.search(search)
    end
  end
end
