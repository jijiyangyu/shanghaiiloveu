class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.column :user_id, :integer, :null=>false
      t.column :question_id, :integer, :null =>false
      t.column :choice_id, :integer, :null =>false
      t.column :answer, :text
      t.timestamps
    end
    add_index :answers, :question_id
    add_index :answers, :user_id
  end

  def self.down
    drop_table :answers
  end
end
