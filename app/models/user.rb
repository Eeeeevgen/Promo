# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  name              :string
#  email             :string
#  crypted_password  :string
#  password_salt     :string
#  persistence_token :string
#  avatar            :string
#  remote_avatar_url :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  token             :string
#

class User < ApplicationRecord
  acts_as_authentic do |c|
    c.login_field = :email
    c.validate_email_field = true
    c.validate_login_field = false
    c.ignore_blank_passwords = true
  end

  has_many :authorizations, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, :email, presence: true
  mount_uploader :avatar, AvatarUploader
end
