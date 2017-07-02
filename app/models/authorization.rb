require 'pp'

class Authorization < ApplicationRecord
  belongs_to :user
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user =  User.find_by(email: auth_hash["info"]["email"])
      unless user
        user = User.new :name => auth_hash["info"]["name"],
                        :email => auth_hash["info"]["email"],
                        :password => auth_hash.credentials.token,
                        :password_confirmation => auth_hash.credentials.token,
                        :remote_avatar_url => auth_hash["info"]["image"]
        user.save!
      end
      auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end
    auth
  end
end
