class Task < ApplicationRecord
  validates :task_name, :task_detail, :expiry_date, presence: true

  enum status: {
    未着手: 1,
    着手中: 2,
    完了: 3
  }

  enum priority:{
    低: 1,
    中: 2,
    高: 3
  }

  scope :recent_order, -> {order(created_at: :desc)}
  scope :expiry_order_desc, -> {order(expiry_date: :desc)}
  scope :expiry_order_asc, -> {order(expiry_date: :asc)}
  scope :priority_order_desc, -> {order(priority: :desc)}
  scope :priority_order_asc, -> {order(priority: :asc)}

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
    if search[:sort_keyword] == "期限▼"
      Task.search(search).expiry_order_desc
    elsif search[:sort_keyword] == "期限▲"
      Task.search(search).expiry_order_asc
    elsif search[:sort_keyword] == "優先▼"
      Task.search(search).priority_order_desc
    elsif search[:sort_keyword] == "優先▲"
      Task.search(search).priority_order_asc
    else
      Task.search(search)
    end
  end
end
