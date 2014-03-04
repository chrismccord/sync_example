class Project < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :destroy
  has_many :comments, through: :todos

  validates :name, :user, presence: true

  def completed_todo_count
    self.todos.completed.count
  end
  
  sync :all
  
  sync_scope :by_user, ->(user) { where(user_id: user.id) }
end
