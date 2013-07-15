module ApplicationHelper
  def user_logged(&block)
    block.call if current_user
    nil
  end

  def indicators_map
    {"Title" => "title",
     "Couple Chemistry" => "indicators.couple_chemistry.total",
     "Guy's looks" => "indicators.he_handsome.total",
     "Girl's looks" => "indicators.she_handsome.total"}
  end

  def admins_only(&block)
    block.call if current_user and current_user.try(:admin)
    nil
  end
end
