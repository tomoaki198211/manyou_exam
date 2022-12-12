class Task < ApplicationRecord
  belongs_to :user
  has_many :tidies, dependent: :destroy
  has_many :labels, through: :tidies
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
    search[:keyword] = nil if search[:status].blank?
    search[:status] = nil if search[:status].blank?
    if search[:label_id].blank?
      search[:label_id] = nil
    else
      task_id = Tidy.where(label_id: search[:label_id]).pluck(:task_id)
    end
    if search[:keyword] && search[:status] && search[:label_id]
      Task.where("task_name LIKE ?", "%#{search[:keyword]}%").where(status: search[:status]).where(id: task_id)
    elsif search[:keyword] && search[:status]
      Task.where("task_name LIKE ?", "%#{search[:keyword]}%").where(status: search[:status])
    elsif search[:keyword] && search[:label_id]
      Task.where("task_name LIKE ?", "%#{search[:keyword]}%").where(id: task_id)
    elsif search[:status] && search[:label_id]
      Task.where(status: search[:status]).where(id: task_id)
    elsif search[:keyword]
      Task.where("task_name LIKE ?", "%#{search[:keyword]}%")
    elsif search[:status]
      Task.where(status: search[:status])
    elsif search[:label_id]
      Task.where(id: task_id)
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
      Task.search(search).recent_order
    end
  end
end
