class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.seller?
      can :manage, Product, user_id: user.id
      can %i(show edit update create), User
    else
      can :read, Product
      can %i(show edit update create), User
    end
  end
end
