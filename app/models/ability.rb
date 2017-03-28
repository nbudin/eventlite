class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event
    can :read, Page

    return unless user

    if user.admin?
      can :manage, :all
    end
  end
end
