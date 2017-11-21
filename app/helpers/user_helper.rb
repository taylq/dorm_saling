module UserHelper
  def position_choice
    User.positions.keys.map{|position| [t("#{position}"), position]}
  end
end
