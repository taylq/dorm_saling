class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can %i(create show), Message
      can %i(show edit update create), User
    end
  end
end
