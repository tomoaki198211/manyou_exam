class Task < ApplicationRecord
  validates :task_name, :task_detail, presence: true
end
