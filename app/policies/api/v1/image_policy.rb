class Api::V1::ImagePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record[2] # excluding namespace
  end

  def show?
    true
  end

  def index?
    true
  end

  def create?
    true
  end

  def destroy?
    @user && (@user.admin? || @user.id == @record.user.id)
  end
end