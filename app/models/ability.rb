class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.seller?
      can %i(index show new create destroy), Order, user_id: user.id
      can %i(edit update), Order
      can :manage, Product, user_id: user.id
      can %i(show edit update create), User
    else
      can :manage, Order, user_id: user.id
      can :show, Product, AreasProduct do |ap|
        ap.area_ids.include?(user.area_id)
      end
      can :index, Product
      can %i(show edit update create), User
    end
  end
end
