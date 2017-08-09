class User < ApplicationRecord
  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_email_field = true
    c.validate_login_field = false
    c.ignore_blank_passwords = true
  end

  has_many :authorizations, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :name, :email, presence: true
  mount_uploader :avatar, AvatarUploader

  # def admin?
  #   self.admin
  # end
end
