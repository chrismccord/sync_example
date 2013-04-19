class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :user_id
      t.integer :todo_id
      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :todo_id
  end
end
