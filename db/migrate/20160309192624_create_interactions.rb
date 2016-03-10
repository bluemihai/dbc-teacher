class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.integer :minutes
      t.string :topic
      t.integer :challenge_id
      t.integer :rating
      t.text :learned

      t.timestamps null: false
    end
  end
end
