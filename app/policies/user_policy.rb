class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def edit?
    @user && @user.id == @record.id
  end

  def upload_form?
    @user && @user.id == @record.id
  end
end