class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :user_id
      t.integer :todos_count, null: false, default: 0

      t.timestamps
    end

    add_index :projects, :user_id
  end
end
