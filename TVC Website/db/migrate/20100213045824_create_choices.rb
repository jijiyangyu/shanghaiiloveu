class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.column :question_id, :integer, :null =>false
      t.column :choice_num, :integer,:limit=>2, :null =>false
      t.column :body, :string, :null =>false
      t.column :remark, :text
      t.timestamps
    end
    add_index :choices, :question_id
  end

  def self.down
    drop_table :choices
  end
end
