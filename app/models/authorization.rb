require 'pp'

class Authorization < ApplicationRecord
  belongs_to :user
  validates :provider, :uid, :presence => true

  def self.find_or_create(auth_hash)
    pp auth_hash
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
      user.save
      Rails.logger.info(user.errors.inspect)

      auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    end

    auth
  end
end
