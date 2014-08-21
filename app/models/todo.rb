class Todo < ActiveRecord::Base
  belongs_to :project, counter_cache: true, touch: true
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :title, presence: true

  scope :ordered,   -> { order(title: :asc, created_at: :desc) }
  scope :completed, -> { where(complete: true ) }
  scope :recently_updated, -> { order("updated_at DESC")}

  # Set up automatic syncing of todo partials
  sync :all
  
  # Update the partials of the associated parent project 
  # whenever a todo is created/updated/deleted 
  sync_touch :project, :user

  # Create some sync scopes for updating multiple sets of records automatically
  sync_scope :by_project, ->(project) { ordered.where(project_id: project.id) }
  sync_scope :by_user, ->(user) { ordered.where(user_id: user.id) }

end
