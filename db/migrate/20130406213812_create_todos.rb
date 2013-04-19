class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.references :user
      t.integer :project_id
      t.integer :comments_count, null: false, default: 0
      t.boolean :complete, null: false, default: false
      t.timestamps
    end

    add_index :todos, :user_id
    add_index :todos, :project_id
    add_index :todos, :complete
  end
end
