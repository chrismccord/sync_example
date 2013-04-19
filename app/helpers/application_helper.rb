module ApplicationHelper

  def featured_user
    User.order('created_at ASC').first
  end
end
