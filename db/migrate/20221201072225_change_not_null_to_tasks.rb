class ChangeNotNullToTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :task_name, false
    change_column_null :tasks, :task_detail, false
  end
end
