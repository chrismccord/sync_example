class Todo < ActiveRecord::Base
  belongs_to :project, counter_cache: true
  has_many :comments, dependent: :destroy

  scope :ordered, -> { order("created_at ASC") }

  def user
    project.user
  end
end
