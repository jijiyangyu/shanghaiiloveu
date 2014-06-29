class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.column :sessid, :string
      t.column :data, :text
      t.column :updated_at, :datetime
      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
