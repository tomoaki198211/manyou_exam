class CreateTidies < ActiveRecord::Migration[6.0]
  def change
    create_table :tidies do |t|
      t.references :label, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
