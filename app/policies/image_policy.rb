class ImagePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def partial?
    @user && @user.id == @record.user.id ? true : false
  end

  def like?
    @user && @record.user.id != @user.id ? true : false
  end
end
