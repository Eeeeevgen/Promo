class User < ApplicationRecord
  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_email_field = true
    c.validate_login_field = false
    c.ignore_blank_passwords  = true
    # c.validate_password_field = false

    # external = Proc.new { |r| r.externally_authenticated? }
    #
    # c.merge_validates_confirmation_of_password_field_options(:unless => external)
    # c.merge_validates_length_of_password_confirmation_field_options(:unless => external)
    # c.merge_validates_length_of_password_field_options(:unless => external)
  end

  has_many :authorizations
  has_many :images

  validates :name, :email, :presence => true
  mount_uploader :avatar, AvatarUploader

  def add_provider(auth_hash)
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end

  # def externally_authenticated?
  #   self.ext? ? true : false
  # end
end
