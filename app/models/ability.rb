class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    user_id = user.id
    if user.admin?
      can :manage, :all
    elsif user.seller?
      can_of_seller user_id
    else
      can_of_user user_id
    end
  end

  private

  def can_of_user user_id
    can :manage, Order, user_id: user_id
    can :show, Product, AreasProduct do |ap|
      ap.area_ids.include?(user.area_id)
    end
    can :index, Product
    can %i(show edit update create), User
  end

  def can_of_seller user_id
    can %i(index show new create destroy), Order, user_id: user_id
    can %i(edit update), Order
    can %i(read), Product
    can %i(edit update create destroy), Product, user_id: user_id
    can %i(show edit update create), User
  end
end
