class User < ApplicationRecord
  acts_as_authentic do |c|
    c.ignore_blank_passwords = true #ignoring passwords
  end

  has_many :authorizations
  has_many :images
  validates :name, :email, :presence => true

  def add_provider(auth_hash)
    # Check if the provider already exists, so we don't add it twice
    unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
  end
end
