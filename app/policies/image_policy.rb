class ImagePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def partial?
    @user && @user.id == @record.user.id
  end

  def like?
    @user && @record.user.id != @user.id
  end

  def add_comment?
    @user
  end
end
