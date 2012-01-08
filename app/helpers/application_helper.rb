module ApplicationHelper
  def user_logged(&block)
    block.call if current_user
    nil
  end
end
