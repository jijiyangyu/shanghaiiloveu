class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.column :sequence_num, :integer, :null =>false
      t.column :body, :text, :null =>false
      t.column :remark, :text
      t.column :open_or_not, :boolean, :null =>false
      t.timestamps
    end
    add_index :questions, :sequence_num, :UNIQUE
  end

  def self.down
    drop_table :questions
  end
end
