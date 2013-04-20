class Project < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :destroy

  def completed_todo_count
    self.todos.completed.count
  end
end
