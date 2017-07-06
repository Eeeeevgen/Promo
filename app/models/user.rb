class User < ApplicationRecord
  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_email_field = true
    c.validate_login_field = false
    c.ignore_blank_passwords  = true
  end

  has_many :authorizations, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :name, :email, :presence => true
  mount_uploader :avatar, AvatarUploader

  def add_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end
end
