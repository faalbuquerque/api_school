class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :description
      t.string :time
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
