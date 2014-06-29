require "migration_helper"
class CreateForeignKeys < ActiveRecord::Migration
 extend MigrationHelper
  def self.up
    create_foreign_key(:people, :user_id, :users)
    create_foreign_key(:resources, :user_id, :users)
    create_foreign_key(:comments, :user_id, :users)
    create_foreign_key(:maps, :question_id, :questions)
    create_foreign_key(:choices, :question_id, :questions)
    create_foreign_key(:answers, :user_id, :users)
    create_foreign_key(:answers, :question_id, :questions)
  end

  def self.down
    remove_foreign_key(:people, :user_id, :users)
    remove_foreign_key(:resources, :user_id, :users)
    remove_foreign_key(:comments, :user_id, :users)
    remove_foreign_key(:maps, :question_id, :questions)
    remove_foreign_key(:choices, :question_id, :questions)
    remove_foreign_key(:answers, :user_id, :users)
    remove_foreign_key(:answers, :question_id, :questions)
  end
end