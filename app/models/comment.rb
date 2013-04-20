class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :todo, counter_cache: true

  validates_presence_of :message

  scope :ordered, -> { order("created_at ASC") }
  scope :recently_updated, -> { order("updated_at DESC")}

  def project
    todo.project
  end

  def to_s
    self.message
  end
end
