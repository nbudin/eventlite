class Drops::UserDrop < Liquid::Drop
  attr_reader :user
  delegate :email, :admin, to: :user

  def initialize(user)
    @user = user
  end
end
