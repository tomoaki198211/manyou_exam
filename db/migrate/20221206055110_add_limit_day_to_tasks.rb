class AddLimitDayToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :expiry_date, :date, null: false
  end
end
