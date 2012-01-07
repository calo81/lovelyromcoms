module ApplicationHelper
  def admins_only(&block)
    block.call if current_user
    nil
  end
end
